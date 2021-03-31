//
//  SceneDelegate.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/27/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import UIKit
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var appCoordinator: AppCoordinator!
    private let disposeBag = DisposeBag()
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        window.makeKeyAndVisible()
        appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
            .subscribe()
            .disposed(by: disposeBag)
    }
    
}

