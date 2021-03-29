//
//  ProductDetailService.swift
//  JobPage
//
//  Created Ramitha Wirasinha on 3/29/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import RxSwift

public protocol ProductDetailServiceFetching {
    func fetchProductDetails() -> Observable<Product>
}

class ProductDetailService: ProductDetailServiceFetching {
    
    private let client: HTTPClientType
    
    public init(client: HTTPClientType) {
        self.client = client
    }
    
    func fetchProductDetails() -> Observable<Product> {
        Logger.debug("Preparing to fetch product details")
        return client.request(ApiRouter.getProducts)
    }
}
