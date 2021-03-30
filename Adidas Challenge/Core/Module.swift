//
//  Module.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/27/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import UIKit

public struct Module<T> {
    public let coordinator: BaseCoordinator<T>
    
    public init(coordinator: BaseCoordinator<T>) {
        self.coordinator = coordinator
    }
}

public protocol ModuleBuildable: class {
    func buildModule<T>() -> Module<T>?
    func buildModule<T>(with window: UIWindow) -> Module<T>?
    func buildModule<T>(with rootViewController: UINavigationController) -> Module<T>?
    func buildModule<T>(with rootViewController: UIViewController, context: Any?) -> Module<T>?
    func buildModule<T>(with rootViewController: UINavigationController, context: Any?) -> Module<T>?
}

extension ModuleBuildable {
    
    public func buildModule<T>() -> Module<T>? {
        return nil
    }
    
    public func buildModule<T>(with window: UIWindow) -> Module<T>? {
        return nil
    }
    
    public func buildModule<T>(with rootViewController: UINavigationController) -> Module<T>? {
        return nil
    }
    
    public func buildModule<T>(with rootViewController: UINavigationController, context: Any?) -> Module<T>? {
        return nil
    }
    
    public func buildModule<T>(with rootViewController: UIViewController, context: Any?) -> Module<T>? {
        return nil
    }
}

