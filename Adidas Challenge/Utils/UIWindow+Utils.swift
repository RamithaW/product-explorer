//
//  UIWindow+Utils.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/27/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import UIKit

public extension UIWindow {
    func setRootViewController(viewController: UIViewController) {
        rootViewController = viewController
        makeKeyAndVisible()
    }
}
