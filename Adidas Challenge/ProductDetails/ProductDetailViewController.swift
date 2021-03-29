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
        scrollView.showsVerticalScrollIndicator = false
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
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.text = "$100.00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.text = "Description here"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        scrollView.addSubview(stackView)
        scrollView.backgroundColor = .green
        
        for _ in 1 ... 20 {
            stackView.addArrangedSubview(ReviewView())
        }
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
            
            stackView.topAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor, constant: 20),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
        ])
    }

    func setupObservers() {}
}

class ReviewView: UIView {
    
    lazy var reviewTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Review text here.."
        label.backgroundColor = .systemPink
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "3 out of 5"
        label.font = label.font.withSize(10)
        label.backgroundColor = .orange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(){
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .white
        addSubview(reviewTextLabel)
        addSubview(ratingLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: topAnchor),
            ratingLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            reviewTextLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 2),
            reviewTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            reviewTextLabel.leftAnchor.constraint(equalTo: leftAnchor),
            reviewTextLabel.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor)
        ])
    }
}

