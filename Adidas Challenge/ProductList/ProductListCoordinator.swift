//
//  ProductListCoordinator.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/27/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import RxSwift

class ProductListCoordinator: BaseCoordinator<Void> {
    
    private weak var window: UIWindow?
    private let viewController: UIViewController
    private let navigationController: UINavigationController
    
    init(window: UIWindow?, viewController: UIViewController) {
        self.window = window
        self.viewController = viewController
        self.navigationController = UINavigationController()
    }
    
    override public func start() -> Observable<Void> {
        navigationController.setViewControllers([viewController], animated: true)
        window?.setRootViewController(viewController: navigationController)
        
        return .never()
    }
}
