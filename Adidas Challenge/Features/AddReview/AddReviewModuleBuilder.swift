//
//  AddReviewModuleBuilder.swift
//  ShiftOverview
//
//  Created Ramitha Wirasinha on 3/29/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import UIKit


protocol AddReviewModuleBuildable: ModuleBuildable {
    func buildModule<T>(with rootViewController: UIViewController, context: Any?) -> Module<T>?
}

class AddReviewModuleBuilder: AddReviewModuleBuildable {
    
    private let container: DependencyManager
    
    public init(container: DependencyManager) {
        self.container = container
    }
    
    func buildModule<T>(with rootViewController: UIViewController, context: Any?) -> Module<T>? {
        guard let product = context as? Product else { return nil }
        
        registerService()
        registerUsecase()
        registerViewModel(product: product)
        registerView()
        registerCoordinator(rootViewController: rootViewController)
        
        guard let coordinator = container.resolve(AddReviewCoordinator.self) else {
            return nil
        }
        
        return Module(coordinator: coordinator) as? Module<T>
    }
}

private extension AddReviewModuleBuilder {
    
    func registerUsecase() {
        container.register(AddReviewInteractable.self) { [weak self] in
            guard let self = self,
                let service = self.container.resolve(AddReviewServicePerforming.self) else { return nil }
            return AddReviewUseCase(service: service)
        }
    }
    
    func registerService() {
        container.register(HTTPClientType.self) { HttpClient() }
        container.register(AddReviewServicePerforming.self) { [weak self] in
            guard let httpClient = self?.container.resolve(HTTPClientType.self) else { return nil }
            
            return AddReviewService(client: httpClient)
        }
    }
    
    func registerViewModel(product: Product) {
        container.register(AddReviewViewModel.self) { [weak self] in
            guard let useCase = self?.container.resolve(AddReviewInteractable.self) else { return nil }
            
            return AddReviewViewModel(useCase: useCase, product: product)
        }
    }
    
    func registerView() {
        container.register(AddReviewViewController.self) { [weak self] in
            guard let viewModel = self?.container.resolve(AddReviewViewModel.self) else {
                return nil
            }
            
            return AddReviewViewController.create(with: viewModel)
        }
    }
    
    func registerCoordinator(rootViewController: UIViewController? = nil) {
        container.register(AddReviewCoordinator.self) { [weak self] in
            guard let viewController = self?.container.resolve(AddReviewViewController.self) else {
                return nil
            }
            
            let coordinator = AddReviewCoordinator(rootViewController: rootViewController, viewController: viewController)
            return coordinator
        }
    }
}
