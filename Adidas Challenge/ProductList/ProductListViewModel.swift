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

struct ProductListViewModelInputs {
}

struct ProductListViewModelOutputs {
}

public protocol ProductListViewModellable: ViewModelType {
    
}
    
public class ProductListViewModel: ProductListViewModellable {
    
    private let useCase: ProductListInteractable
    
    let inputs = ProductListViewModelInputs()
    let outputs = ProductListViewModelOutputs()
    
    public let disposeBag: DisposeBag = DisposeBag()
    
    init(useCase: ProductListInteractable) {
        self.useCase = useCase
        
        useCase.fetchProducts().subscribe(onNext: { p in
            print(p)
        }, onError: { (error) in
            print(error)
        }).disposed(by: disposeBag)
    }
}
