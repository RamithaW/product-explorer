//
//  ProductDetailModuleBuilder.swift
//  JobPage
//
//  Created Ramitha Wirasinha on 3/29/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import UIKit

protocol ProductDetailModuleBuildable: ModuleBuildable {}

class ProductDetailModuleBuilder: ProductDetailModuleBuildable {
    
    private let container: DependencyManager
    
    public init(container: DependencyManager) {
        self.container = container
    }
    
    func buildModule<T>(with rootViewController: UINavigationController, context: Any?) -> Module<T>? {
        guard let product = context as? Product else { return nil }
        
        registerService()
        registerUsecase()
        registerViewModel(withProduct: product)
        registerView()
        registerCoordinator(rootViewController: rootViewController)
        
        guard let coordinator = container.resolve(ProductDetailCoordinator.self) else {
            return nil
        }
        
        return Module(coordinator: coordinator) as? Module<T>
    }
}

private extension ProductDetailModuleBuilder {
    
    func registerUsecase() {
        container.register(ProductDetailInteractable.self) { [weak self] in
            guard let self = self,
                let service = self.container.resolve(ProductDetailServiceFetching.self) else { return nil }
            return ProductDetailUseCase(service: service)
        }
    }
    
    func registerService() {
        container.register(HTTPClientType.self) { HttpClient() }
        
        container.register(ProductDetailServiceFetching.self) { [weak self] in
             guard let httpClient = self?.container.resolve(HTTPClientType.self) else { return nil}
            return ProductDetailService(client: httpClient)
        }
    }
    
    func registerViewModel(withProduct product: Product) {
        container.register(ProductDetailViewModel.self) { [weak self] in
            guard let useCase = self?.container.resolve(ProductDetailInteractable.self) else { return nil }
            
            return ProductDetailViewModel(useCase: useCase, product: product)
        }
    }
    
    func registerView() {
        container.register(ProductDetailViewController.self) { [weak self] in
            guard let viewModel = self?.container.resolve(ProductDetailViewModel.self) else {
                return nil
            }
            
            return ProductDetailViewController.create(with: viewModel)
        }
    }
    
    func registerCoordinator(rootViewController: UINavigationController? = nil) {
        container.register(ProductDetailCoordinator.self) { [weak self] in
            guard let viewController = self?.container.resolve(ProductDetailViewController.self) else {
                return nil
            }
            
            let coordinator = ProductDetailCoordinator(rootViewController: rootViewController, viewController: viewController)
            coordinator.dismissedView = viewController.viewModel.outputs.viewDismissed
            return coordinator
        }
    }
}
