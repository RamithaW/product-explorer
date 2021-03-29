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
    
    lazy var refreshControl: UIRefreshControl = {
        var refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refreshControl)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var errorStateView: ErrorStateView = {
        let loadingView = ErrorStateView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupObservers()
        
        viewModel.inputs.loadData.onNext(())
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func showErrorStateView() {
        view.addSubview(errorStateView)
        NSLayoutConstraint.activate([
            errorStateView.topAnchor.constraint(equalTo: view.topAnchor),
            errorStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            errorStateView.leftAnchor.constraint(equalTo: view.leftAnchor),
            errorStateView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func hideErrorStateView() {
        UIView.animate(withDuration: 1.5, animations: { [weak self] in
            self?.errorStateView.alpha = 0
        }) {[weak self] _ in
            self?.errorStateView.alpha = 1
            self?.errorStateView.removeFromSuperview()
        }
        
    }
    
    func setupObservers() {
        observeViewReloading()
        observeErrorStateView()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        guard let refreshControl = sender as? UIRefreshControl else { return }
        
        refreshControl.endRefreshing()
        viewModel.inputs.loadData.onNext(())
    }
}

private extension ProductListViewController {
    
    func observeViewReloading() {
        viewModel.outputs.reloadView.subscribe(onNext: { [weak self] _ in
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
        }).disposed(by: viewModel.disposeBag)
    }
    
    func observeErrorStateView() {
        viewModel.outputs.showErrorStateView.subscribe(onNext: { [weak self] (shouldShow) in
            shouldShow ? self?.showErrorStateView() : self?.hideErrorStateView()
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
            cell.textLabel?.text = "\(data.name) \(data.id)"
            cell.backgroundColor = .white
            return cell
        }
        
        preconditionFailure("Could not dequeue cell for product list tableview")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.inputs.tappedItematIndex.onNext(indexPath.row)
    }
}
