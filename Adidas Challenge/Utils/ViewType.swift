//
//  ViewType.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/28/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import UIKit

public protocol ViewModelType: class {}

public protocol ViewType {
    associatedtype GenericViewModel
    var viewModel: GenericViewModel! { get set }
    
    func setupUI()
    func setupObservers()
    func setupConstraints()
}

public extension ViewType {
    
    func setupObservers() {}
 
    static func create<GenericVC: ViewType>(viewModel: GenericViewModel) -> GenericVC where GenericVC: UIViewController, GenericViewModel == GenericVC.GenericViewModel {

        var vc = GenericVC()
        vc.viewModel = viewModel
        
        return vc
    }
}
