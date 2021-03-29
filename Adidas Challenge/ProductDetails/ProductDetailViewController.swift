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
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var productImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.backgroundColor = .red
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.text = "Product name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        label.text = "dasds"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.text = "dasds"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dummyView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

	override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupObservers()
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

    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(productImageView)
        scrollView.addSubview(productNameLabel)
        scrollView.addSubview(productPriceLabel)
        scrollView.addSubview(productDescriptionLabel)
        scrollView.addSubview(dummyView)
        scrollView.backgroundColor = .green
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            productImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            productImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            productImageView.heightAnchor.constraint(equalToConstant: 200),
            productImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10),
            productNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.topAnchor),
            productPriceLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            productDescriptionLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 10),
            productDescriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            productDescriptionLabel.rightAnchor.constraint(lessThanOrEqualTo: view.rightAnchor, constant: -20),
            
            dummyView.topAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor, constant: 20),
            dummyView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            dummyView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            dummyView.heightAnchor.constraint(equalToConstant: 500),
            
            dummyView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
        ])
    }

    func setupObservers() {}
}
