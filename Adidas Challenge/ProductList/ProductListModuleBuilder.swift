//
//  ProductListModuleBuilder.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/27/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import UIKit

public protocol ProductListModuleBuildable: ModuleBuildable {}

public class ProductListModuleBuilder: ProductListModuleBuildable {
    
    private let container: DependencyManager
    
    public init(container: DependencyManager) {
        self.container = container
    }
    
    public func buildModule<T>(with window: UIWindow) -> Module<T>? {
        // register use case and service
        registerViewModel()
        registerView()
        registerCoordinator(window: window)
        
        guard let coordinator = container.resolve(ProductListCoordinator.self) else { return nil }
        
        return Module(coordinator: coordinator) as? Module<T>
    }
    
    func registerViewModel() {
        container.register(ProductListViewModel.self) { [weak self] in
            guard let useCase = self?.container.resolve(ProductListInteractable.self) else { return nil }
            
            return ProductListViewModel(useCase: useCase)
        }
    }
    
    func registerView() {
        container.register(ProductListViewController.self) { [weak self] in
            
            return ProductListViewController()
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
