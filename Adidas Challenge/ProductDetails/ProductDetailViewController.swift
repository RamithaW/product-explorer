//
//  ProductDetailViewController.swift
//  JobPage
//
//  Created Ramitha Wirasinha on 3/29/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, ViewType {

    typealias ViewModel = ProductDetailViewModellable
	var viewModel: ViewModel!

	override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.outputs.viewDismissed.onNext(())
    }
}

// MARK: - setupUI

extension ProductDetailViewController {

    func setupUI() {}

    func setupConstraints() {}

    func setupObservers() {}
}
