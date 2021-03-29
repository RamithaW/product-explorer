//
//  AddReviewViewController.swift
//  ShiftOverview
//
//  Created Ramitha Wirasinha on 3/29/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import UIKit

class AddReviewViewController: UIViewController, ViewType {

    typealias ViewModel = AddReviewViewModellable
	var viewModel: ViewModel!

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Let's write a review"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var footer: ProductDetailFooterView = {
        let footer = ProductDetailFooterView()
        footer.translatesAutoresizingMaskIntoConstraints = false
        return footer
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
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
}

// MARK: - setupUI

extension AddReviewViewController {

    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(textView)
        view.addSubview(footer)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            textView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.heightAnchor.constraint(equalToConstant: 100),
            
            footer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            footer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footer.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }

    func setupObservers() {
        footer.footerButtonTapped.bind(to: viewModel.inputs.addReviewTapped).disposed(by: viewModel.disposeBag)
    }
}
