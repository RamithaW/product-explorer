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
    let viewDidLoad = PublishSubject<Void>()
}

public struct ProductListViewModelOutputs {
    let reloadView = PublishSubject<Void>()
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
        inputs.viewDidLoad.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.useCase.fetchProducts().subscribe(onNext: { p in
                self.products = p
                self.outputs.reloadView.onNext(())
            }, onError: { (error) in
                print(error)
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
    
    public func numberOfRowsInSection() -> Int {
        return products.count
    }
    
    public func item(at index: Int) -> Product {
        return products[index]
    }
}
