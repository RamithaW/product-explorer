//
//  ProductDetailFooterView.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/29/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import UIKit
import RxSwift

class ProductDetailFooterView: UIView {
    
    let footerButtonTapped = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add review", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
        setupObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .white
        addSubview(button)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    
    func setupObservers() {
        button.rx.tap.bind(to: footerButtonTapped).disposed(by: disposeBag)
    }
}
