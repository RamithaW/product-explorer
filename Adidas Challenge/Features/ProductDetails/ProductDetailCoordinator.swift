//
//  ProductDetailCoordinator.swift
//  JobPage
//
//  Created Ramitha Wirasinha on 3/29/21.
//  Copyright © 2021 Temper B.V.. All rights reserved.
//

import RxSwift

class ProductDetailCoordinator: BaseCoordinator<Void> {
    
    var dismissedView = PublishSubject<Void>()
    
    private weak var rootViewController: UINavigationController?
    private let viewController: UIViewController
    
    init(rootViewController: UINavigationController?, viewController: UIViewController) {
        self.rootViewController = rootViewController
        self.viewController = viewController
    }
    
    override public func start() -> Observable<Void> {
        rootViewController?.pushViewController(viewController, animated: true)
        
        return dismissedView
    }
}
