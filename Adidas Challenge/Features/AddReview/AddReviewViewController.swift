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
        label.text = "Write a review"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send", for: .normal)
        return button
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5
        textView.backgroundColor = .systemGray6
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
        view.addSubview(sendButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            textView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.heightAnchor.constraint(equalToConstant: 200),
            
            sendButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            sendButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }

    func setupObservers() {
        sendButton.rx.tap.map{ [weak self] in
            self?.textView.text
        }.compactMap{ $0 }.bind(to: viewModel.inputs.addReviewTapped).disposed(by: viewModel.disposeBag)
    }
}
