//
//  ProductListUseCase.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/27/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import RxSwift

public protocol ProductListInteractable {
    func fetchProducts() -> Observable<[Product]>
}

class ProductListUseCase: ProductListInteractable {

    private let service: ProductListServiceFetching
    
    init(service: ProductListServiceFetching) {
        self.service = service
    }
    
    func fetchProducts() -> Observable<[Product]> {
        return service.fetchProducts()
    }
}

