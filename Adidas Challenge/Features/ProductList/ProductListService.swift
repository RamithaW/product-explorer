//
//  ProductListService.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/27/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import RxSwift

public protocol ProductListServiceFetching {
    func fetchProducts() -> Observable<[Product]>
}

class ProductListService: ProductListServiceFetching {
    
    private let client: HTTPClientType
    
    public init(client: HTTPClientType) {
        self.client = client
    }
    
    func fetchProducts() -> Observable<[Product]> {
        Logger.debug("Preparing to fetch product list")
        return client.request(ApiRouter.getProducts)
    }
}
