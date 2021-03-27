//
//  AppCoordinator.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/27/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        return showProductList()
    }
    
    func showProductList() -> Observable<Void> {
        guard let productListCoordinator: BaseCoordinator<Void> = ProductListModuleBuilder(container: DependencyManager.shared).buildModule(with: window)?.coordinator else {
            preconditionFailure("[AppCoordinator] Cannot get ProductListModuleBuilder from module builder")
        }
        
        return coordinate(to: productListCoordinator)
    }
}
