//
//  ProductListViewController.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/27/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController, ViewType {

    var viewModel: ProductListViewModellable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupObservers()
        
        viewModel.inputs.viewDidLoad.onNext(())
    }
    
    func setupUI() {
        view.backgroundColor = .blue
    }
    
    func setupConstraints() {
        
    }
    
    func setupObservers() {
        observeViewReloading()
    }
}

private extension ProductListViewController {
     
    func observeViewReloading() {
        viewModel.outputs.reloadView.subscribe(onNext: { [weak self] _ in
            self?.view.backgroundColor = .red
        }).disposed(by: viewModel.disposeBag)
    }
}
