//
//  ProductDetailCoordinator.swift
//  JobPage
//
//  Created Ramitha Wirasinha on 3/29/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import RxSwift

class ProductDetailCoordinator: BaseCoordinator<Void> {
    
    var addReview = PublishSubject<Product>()
    var dismissedView = PublishSubject<Void>()
    var reloadProductDetails = PublishSubject<Void>()
    
    private weak var rootViewController: UINavigationController?
    private let viewController: UIViewController
    private let addReviewModuleBuilder: AddReviewModuleBuildable
    
    init(rootViewController: UINavigationController?, viewController: UIViewController, addReviewModuleBuilder: AddReviewModuleBuildable) {
        self.rootViewController = rootViewController
        self.viewController = viewController
        self.addReviewModuleBuilder = addReviewModuleBuilder
    }
    
    override public func start() -> Observable<Void> {
        rootViewController?.pushViewController(viewController, animated: true)
        
        addReview.subscribe(onNext: { [weak self] product in
            guard let self = self, let addReviewCoordinator = self.addReviewModuleBuilder.buildModule(with: self.viewController, context: product)?.coordinator as? AddReviewCoordinator else { return }
            
            Logger.info("Navigating to Add Review screen")
            self.coordinate(to: addReviewCoordinator).subscribe{ [weak self] _ in
                self?.reloadProductDetails.onNext(())
            }.disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
        return dismissedView
    }
}
