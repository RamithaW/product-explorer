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
    
    init(rootViewController: UIViewController?, viewController: UIViewController) {
        self.rootViewController = rootViewController
        self.viewController = viewController
    }
    
    override public func start() -> Observable<Void> {
        rootViewController?.present(viewController, animated: true, completion: nil)
        
        return .never()
    }
}
