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
        label.font = label.font.withSize(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Ideally this would be stars but adding a label for now
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(withReview review: Review){
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
        populate(using: review)
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
            reviewTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            reviewTextLabel.leftAnchor.constraint(equalTo: leftAnchor),
            reviewTextLabel.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor)
        ])
    }
    
    func populate(using review: Review) {
        reviewTextLabel.text = review.text
        ratingLabel.text = "\(review.rating) out of \(ApplicationConstants.maxRating)"
    }
}
