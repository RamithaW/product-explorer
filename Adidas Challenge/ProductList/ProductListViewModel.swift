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

public class ProductListViewModel {
    
    private let useCase: ProductListInteractable
    
    let inputs = ProductListViewModelInputs()
    let outputs = ProductListViewModelOutputs()
    
    public let disposeBag: DisposeBag = DisposeBag()
    
    init(useCase: ProductListInteractable) {
        self.useCase = useCase
    }
}
