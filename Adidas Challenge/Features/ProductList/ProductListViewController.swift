//
//  ProductListViewController.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/27/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import UIKit
import RxSwift

class ProductListViewController: UIViewController, ViewType, LoadingIndicatable, ErrorIndicatable {
    
    let loadingView = LoadingView()
    var viewModel: ProductListViewModellable!
    
    lazy var refreshControl: UIRefreshControl = {
        var refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ProductCell.self, forCellReuseIdentifier: "\(ProductCell.self)")
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refreshControl)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let reloadButtonTapped = PublishSubject<Void>()
    
    lazy var errorStateView: ErrorStateView = {
        let loadingView = ErrorStateView(reloadButtonTapped: reloadButtonTapped)
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
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
        
        title = "Adidas"
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupObservers() {
        observeViewReloading()
        observeErrorStateView()
        observeLoadingState()
        observeReloadButtonTap()
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
            self?.hideLoadingView()
        }).disposed(by: viewModel.disposeBag)
    }
    
    func observeErrorStateView() {
        viewModel.outputs.showErrorStateView.subscribe(onNext: { [weak self] (shouldShow) in
            shouldShow ? self?.showErrorStateView() : self?.hideErrorStateView()
        }).disposed(by: viewModel.disposeBag)
    }
    
    func observeLoadingState() {
        viewModel.outputs.showLoadingView.subscribe(onNext: { [weak self] show in
            show ? self?.showLoadingView() : self?.hideLoadingView()
        }).disposed(by: viewModel.disposeBag)
    }
    
    func observeReloadButtonTap() {
        reloadButtonTapped.bind(to: viewModel.inputs.reloadButtonTapped).disposed(by: viewModel.disposeBag)
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProductCell.self)", for: indexPath) as? ProductCell else { preconditionFailure("Could not dequeue cell for product list tableview")}
        
        let product = viewModel.item(at: indexPath.row)
        cell.selectionStyle = .none
        cell.setup(with: ProductCellData(name: product.name, imageURL: product.imgUrl, price: "\(ApplicationConstants.currencySymbol) \(product.price)", description: product.description))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.inputs.tappedItemAtIndex.onNext(indexPath.row)
    }
}

extension ProductListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        viewModel.inputs.searchPhraseEntered.onNext(text)
    }
}
