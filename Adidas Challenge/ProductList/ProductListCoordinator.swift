//
//  ProductListCoordinator.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/27/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import RxSwift

class ProductListCoordinator: BaseCoordinator<Void> {
    
    var showProductDetails = PublishSubject<Product>()
    
    private weak var window: UIWindow?
    private let viewController: UIViewController
    private let navigationController: UINavigationController
    private let productDetailModuleBuilder: ProductDetailModuleBuildable
    
    init(window: UIWindow?, viewController: UIViewController, productDetailModuleBuilder: ProductDetailModuleBuildable) {
        self.window = window
        self.viewController = viewController
        self.navigationController = UINavigationController()
        self.productDetailModuleBuilder = productDetailModuleBuilder
    }
    
    override public func start() -> Observable<Void> {
        navigationController.setViewControllers([viewController], animated: true)
        window?.setRootViewController(viewController: navigationController)
        
        showProductDetails.subscribe(onNext: { [weak self] (product) in
            
            guard let self = self, let productDetailCoordinator = self.productDetailModuleBuilder.buildModule(with: self.navigationController)?.coordinator as? ProductDetailCoordinator else { return }
            
            self.coordinate(to: productDetailCoordinator).subscribe().disposed(by: self.disposeBag)
            
        }).disposed(by: disposeBag)
        
        return .never()
    }
}
