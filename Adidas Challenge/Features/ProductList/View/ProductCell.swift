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
        
        addSubview(productImageView)
        addSubview(productNameLabel)
        addSubview(productDescriptionLabel)
        addSubview(productPriceLabel)
        
        productImageView.backgroundColor = .white
//        productNameLabel.backgroundColor = .blue
//        productDescriptionLabel.backgroundColor = .yellow
//        productPriceLabel.backgroundColor = .systemPink
    }
    
    func setupConstraints() {
        let imagBottomConstraint = productImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        imagBottomConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            productImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
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
