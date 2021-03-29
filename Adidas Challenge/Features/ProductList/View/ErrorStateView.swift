//
//  LoadingView.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/28/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import UIKit

class ErrorStateView: UIView {
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Sorry something went wrong"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var reloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("reload", for: .normal)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(infoLabel)
        addSubview(reloadButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            infoLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            reloadButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            reloadButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10)
        ])
    }
}
