//
//  UIViewController+Utils.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/31/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import UIKit
import RxSwift

protocol LoadingIndicatable {
    var loadingView: LoadingView { get }
}

extension LoadingIndicatable where Self: UIViewController {
    
    func showLoadingView() {
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leftAnchor.constraint(equalTo: view.leftAnchor),
            loadingView.rightAnchor.constraint(equalTo: view.rightAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func hideLoadingView() {
        UIView.animate(withDuration: 1.5, animations: { [weak self] in
            self?.loadingView.alpha = 0
        }) {[weak self] _ in
            self?.loadingView.alpha = 1
            self?.loadingView.removeFromSuperview()
        }
    }
}

protocol ErrorIndicatable {
    var errorStateView: ErrorStateView { get }
}


extension ErrorIndicatable where Self: UIViewController {
    
    func showErrorStateView() {
        errorStateView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorStateView)
        NSLayoutConstraint.activate([
            errorStateView.topAnchor.constraint(equalTo: view.topAnchor),
            errorStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            errorStateView.leftAnchor.constraint(equalTo: view.leftAnchor),
            errorStateView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func hideErrorStateView() {
        errorStateView.removeFromSuperview()
    }
}
