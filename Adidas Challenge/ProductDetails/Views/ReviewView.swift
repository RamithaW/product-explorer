//
//  ReviewView.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/29/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import UIKit

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
