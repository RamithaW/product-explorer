//
//  ProductListModuleBuilder.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/27/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import UIKit
import RxSwift

public protocol ProductListModuleBuildable: ModuleBuildable {}

public class ProductListModuleBuilder: ProductListModuleBuildable {
    
    private let container: DependencyManager
    var disposeBag = DisposeBag()
    
    public init(container: DependencyManager) {
        self.container = container
    }
    
    public func buildModule<T>(with window: UIWindow) -> Module<T>? {
        registerService()
        registerUseCase()
        registerViewModel()
        registerView()
        registerCoordinator(window: window)
        
        guard let coordinator = container.resolve(ProductListCoordinator.self) else { return nil }
        
        return Module(coordinator: coordinator) as? Module<T>
    }
    
    func registerUseCase() {
        container.register(ProductListInteractable.self) { [weak self] in
            guard let service = self?.container.resolve(ProductListServiceFetching.self) else { return nil }
            return ProductListUseCase(service: service)
        }
    }
    
    func registerService() {
        container.register(HTTPClientType.self) { HttpClient() }
        container.register(ProductListServiceFetching.self) { [weak self] in
            guard let httpClient = self?.container.resolve(HTTPClientType.self) else { return nil}
            
            return ProductListService(client: httpClient, serviceErrorListener: nil)
        }
    }
    
    func registerViewModel() {
        container.register(ProductListViewModellable.self) { [weak self] in
            guard let useCase = self?.container.resolve(ProductListInteractable.self) else { return nil }
            
            return ProductListViewModel(useCase: useCase)
        }
    }
    
    func registerView() {
        container.register(ProductListViewController.self) { [weak self] in
            guard let viewModel = self?.container.resolve(ProductListViewModellable.self) else { return nil }
            
            return ProductListViewController.create(viewModel: viewModel)
        }
    }
    
    func registerCoordinator(window: UIWindow) {
        container.register(ProductListCoordinator.self) { [weak self] in
            guard let viewController = self?.container.resolve(ProductListViewController.self)
                else { return nil }
            
            let coordinator = ProductListCoordinator(window: window, viewController: viewController)
            return coordinator
        }
    }
}
