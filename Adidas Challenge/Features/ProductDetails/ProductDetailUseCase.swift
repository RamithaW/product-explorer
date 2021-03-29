//
//  ProductDetailUseCase.swift
//  JobPage
//
//  Created Ramitha Wirasinha on 3/29/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import RxSwift

public protocol ProductDetailInteractable {
    func fetchProductDetails() -> Observable<Product>
}

class ProductDetailUseCase: ProductDetailInteractable {

    private let service: ProductDetailServiceFetching
    
    init(service: ProductDetailServiceFetching) {
        self.service = service
    }
    
    func fetchProductDetails() -> Observable<Product> {
        service.fetchProductDetails()
    }
}
