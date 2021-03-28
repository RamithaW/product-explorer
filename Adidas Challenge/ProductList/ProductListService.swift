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
    private let disposeBag = DisposeBag()
    
    private let client: HTTPClientType
    private let serviceErrorListener: NSObject?
    
    public init(client: HTTPClientType, serviceErrorListener: NSObject?) {
        self.client = client
        self.serviceErrorListener = serviceErrorListener
    }
    
    func fetchProducts() -> Observable<[Product]> {
        Logger.debug("Preparing to fetch product list")
        return client.request(ApiRouter.getProducts)
    }
}
