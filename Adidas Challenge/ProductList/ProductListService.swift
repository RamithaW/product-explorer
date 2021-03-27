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
        return client.request(ApiRouter.getPosts(userId: 1))
    }
}

public struct Product: Codable {
    let currency: String
    let price: Int
    let id: String
    let name: String
    let description: String
    let imgUrl: String
    let reviews: [Review]
}

public struct Review: Codable {
    let productId: String
    let locale: String
    let rating: Int
    let text: String
}
