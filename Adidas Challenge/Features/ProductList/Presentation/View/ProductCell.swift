//
//  ProductCell.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/29/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import UIKit
import Nuke

struct ProductCellData {
    let name: String
    let imageURL: String
    let price: String
    let description: String
}

class ProductCell: UITableViewCell {
    
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var containterView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
        setupConstraints()
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(with viewData: ProductCellData) {
        productNameLabel.text = viewData.name
        productDescriptionLabel.text = viewData.description
        productPriceLabel.text = viewData.price
        
        guard let imageURL = URL(string: viewData.imageURL) else { return }
        
        let options = ImageLoadingOptions(
            placeholder: UIImage(named: "placeholder"),
            transition: .fadeIn(duration: 0.5)
        )
        
        Nuke.loadImage(with: imageURL, options: options, into: productImageView)
        
    }
}

private extension ProductCell {
    
    func setupUI() {
        addSubview(containterView)
        containterView.addSubview(productImageView)
        containterView.addSubview(productNameLabel)
        containterView.addSubview(productDescriptionLabel)
        containterView.addSubview(productPriceLabel)
        productImageView.backgroundColor = .white
    }
    
    func setupConstraints() {
        let imagBottomConstraint = productImageView.bottomAnchor.constraint(equalTo: containterView.bottomAnchor, constant: -10)
        imagBottomConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            containterView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            containterView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            containterView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containterView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            productImageView.leftAnchor.constraint(equalTo: containterView.leftAnchor, constant: 10),
            productImageView.topAnchor.constraint(equalTo: containterView.topAnchor, constant: 10),
            productImageView.heightAnchor.constraint(equalToConstant: 100),
            productImageView.widthAnchor.constraint(equalToConstant: 100),
            imagBottomConstraint,
            
            productNameLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 10),
            productNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            productDescriptionLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 10),
            productDescriptionLabel.topAnchor.constraint(equalTo: productNameLabel.topAnchor, constant: 30),
            
            productPriceLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 10),
            productPriceLabel.topAnchor.constraint(equalTo: productDescriptionLabel.topAnchor, constant: 30),
        ])
    }
}
