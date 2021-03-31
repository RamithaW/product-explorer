//
//  AddReviewCoordinator.swift
//  ShiftOverview
//
//  Created Ramitha Wirasinha on 3/29/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import RxSwift
import UIKit

class AddReviewCoordinator: BaseCoordinator<Void> {
    
    private weak var rootViewController: UIViewController?
    private let viewController: UIViewController
    var dismiss = PublishSubject<Void>()
    var reviewAdded = PublishSubject<Review>()
    
    init(rootViewController: UIViewController?, viewController: UIViewController) {
        self.rootViewController = rootViewController
        self.viewController = viewController
    }
    
    override public func start() -> Observable<Void> {
        rootViewController?.present(viewController, animated: true, completion: nil)
        
        reviewAdded.subscribe { [weak self] _ in
            self?.dismiss.onNext(())
        }.disposed(by: disposeBag)
        
        return dismiss.take(1).do(onDispose: { [weak self] in
            self?.viewController.dismiss(animated: true, completion: nil)
        })
    }
}
