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
    let tappedItematIndex = PublishSubject<Int>()
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
                self.outputs.reloadView.onNext(())
                self.outputs.showErrorStateView.onNext(false)
            }, onError: { (error) in
                self.outputs.showErrorStateView.onNext(true)
                print("Error while fetching data from the backend")
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
    
    func observeTappedIndices() {
        inputs.tappedItematIndex.subscribe(onNext: { [weak self] (index) in
            guard let selectedProduct = self?.products[index], let self = self else { return }
            
            self.outputs.showProductDetails.onNext(selectedProduct)
        }).disposed(by: disposeBag)
    }
}
