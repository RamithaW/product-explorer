//
//  ProductListViewController.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/27/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController, ViewType {

    var viewModel: ProductListViewModellable!
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.showsVerticalScrollIndicator = false
        tableView.scrollsToTop = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupObservers()
        
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.inputs.viewDidLoad.onNext(())
    }
    
    func setupUI() {
        view.backgroundColor = .blue
        
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupObservers() {
        observeViewReloading()
    }
}

private extension ProductListViewController {
     
    func observeViewReloading() {
        viewModel.outputs.reloadView.subscribe(onNext: { [weak self] _ in
            self?.view.backgroundColor = .red
            self?.tableView.reloadData()
        }).disposed(by: viewModel.disposeBag)
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? UITableViewCell {
            
            let data = viewModel.item(at: indexPath.row)
            cell.textLabel?.text = data.name
            return cell
        }
        
        preconditionFailure("Could not dequeue cell for product list tableview")
    }
    
    
}
