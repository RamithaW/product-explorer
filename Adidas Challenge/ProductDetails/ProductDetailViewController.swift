//
//  ProductDetailViewController.swift
//  JobPage
//
//  Created Ramitha Wirasinha on 3/29/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import UIKit
import RxSwift
import Nuke

class ProductDetailViewController: UIViewController, ViewType {

    typealias ViewModel = ProductDetailViewModellable
	var viewModel: ViewModel!
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var productImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var productDescriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Product Description"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var productReviewTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Reviews"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var footer: ProductDetailFooterView = {
        let footer = ProductDetailFooterView()
        footer.translatesAutoresizingMaskIntoConstraints = false
        return footer
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
        scrollView.addSubview(productDescriptionTitleLabel)
        scrollView.addSubview(productDescriptionLabel)
        scrollView.addSubview(productReviewTitleLabel)
        scrollView.addSubview(stackView)
        view.addSubview(footer)
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: footer.systemLayoutSizeFitting(UIScreen.main.bounds.size).height, right: 0)
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
            productImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10),
            productNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.topAnchor),
            productPriceLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            productDescriptionTitleLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 25),
            productDescriptionTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            productDescriptionLabel.topAnchor.constraint(equalTo: productDescriptionTitleLabel.bottomAnchor, constant: 10),
            productDescriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            productDescriptionLabel.rightAnchor.constraint(lessThanOrEqualTo: view.rightAnchor, constant: -20),
            
            productReviewTitleLabel.topAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor, constant: 25),
            productReviewTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            stackView.topAnchor.constraint(equalTo: productReviewTitleLabel.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            footer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            footer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footer.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }

    func setupObservers() {
        observeProductDetails()
        footer.footerButtonTapped.subscribe { _ in
            print("Button tapped")
        }.disposed(by: viewModel.disposeBag)
    }
    
    func observeProductDetails(){
        viewModel.outputs.showProductDetails.subscribe(onNext: {[weak self] (product) in
            guard let self = self, let product = product else { return }
            
            self.title = product.name
            
            self.productNameLabel.text = product.name
            self.productPriceLabel.text = "\(ApplicationConstants.currencySymbol)\(product.price)"
            self.productDescriptionLabel.text = product.description
            
            product.reviews.forEach { (review) in
                self.stackView.addArrangedSubview(ReviewView(withReview: review))
            }
            
            guard let imageURL = URL(string: product.imgUrl) else { return }
            
            Nuke.loadImage(with: imageURL, into: self.productImageView)
        }).disposed(by: viewModel.disposeBag)
    }
}
