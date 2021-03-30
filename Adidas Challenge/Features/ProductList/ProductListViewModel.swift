//
//  ProductListViewModel.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/27/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public struct ProductListViewModelInputs {
    let loadData = PublishSubject<Void>()
    let tappedItemAtIndex = PublishSubject<Int>()
    let searchPhraseEntered = PublishSubject<String>()
}

public struct ProductListViewModelOutputs {
    let reloadView = PublishSubject<Void>()
    let showErrorStateView = PublishSubject<Bool>()
    let showProductDetails = PublishSubject<Product>()
}

public protocol ProductListViewModellable: ViewModelType {
    var inputs: ProductListViewModelInputs { get }
    var outputs: ProductListViewModelOutputs { get }
    
    func numberOfRowsInSection() -> Int
    func item(at index: Int) -> Product
}

public class ProductListViewModel: ProductListViewModellable {
    
    private let useCase: ProductListInteractable
    private var products = [Product]()
    private var searchedProducts = [Product]()
    
    public let inputs = ProductListViewModelInputs()
    public let outputs = ProductListViewModelOutputs()
    public let disposeBag: DisposeBag = DisposeBag()
    
    init(useCase: ProductListInteractable) {
        self.useCase = useCase
        setupObservers()
    }
    
    func setupObservers() {
        observeDataLoading()
        observeTappedIndices()
        observeSearchPhrase()
    }
    
    public func numberOfRowsInSection() -> Int {
        return products.count
    }
    
    public func item(at index: Int) -> Product {
        return products[index]
    }
}

private extension ProductListViewModel {
    
    func observeDataLoading() {
        inputs.loadData.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.useCase.fetchProducts().subscribe(onNext: { products in
                self.products = products
                self.searchedProducts = products
                self.outputs.reloadView.onNext(())
                self.outputs.showErrorStateView.onNext(false)
            }, onError: { (error) in
                self.outputs.showErrorStateView.onNext(true)
                print("Error while fetching data from the backend")
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
    
    func observeTappedIndices() {
        inputs.tappedItemAtIndex.subscribe(onNext: { [weak self] (index) in
            guard let selectedProduct = self?.products[index], let self = self else { return }
            
            self.outputs.showProductDetails.onNext(selectedProduct)
        }).disposed(by: disposeBag)
    }
    
    func observeSearchPhrase() {
        inputs.searchPhraseEntered.subscribe(onNext: { [weak self] (searchPhrase) in
            guard let self = self else { return }
            
            self.products = self.searchedProducts
            self.outputs.reloadView.onNext(())
            
            guard !searchPhrase.isEmpty else {
                self.products = self.searchedProducts
                return
            }
            
            var searchResults = [Product]()
            // Search the Id
            searchResults.append(contentsOf: self.products.filter { (product) -> Bool in
                product.id.lowercased().contains(searchPhrase.lowercased())
            })
            // Search the description
            searchResults.append(contentsOf: self.products.filter { (product) -> Bool in
                product.description.lowercased().contains(searchPhrase.lowercased())
            })
            // Search the name
            searchResults.append(contentsOf: self.products.filter { (product) -> Bool in
                product.name.lowercased().contains(searchPhrase.lowercased())
            })
            // Search the price
            searchResults.append(contentsOf: self.products.filter { (product) -> Bool in
                String(product.price).contains(searchPhrase)
            })
            
            // remove duplicates
            self.products = searchResults.uniqued()
            self.outputs.reloadView.onNext(())
            
        }).disposed(by: disposeBag)
    }
}
