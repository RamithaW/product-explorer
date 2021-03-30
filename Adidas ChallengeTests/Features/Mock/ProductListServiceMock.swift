//
//  ProductListServiceMock.swift
//  Adidas ChallengeTests
//
//  Created by Ramitha Wirasinha on 3/31/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import Foundation
import RxSwift
@testable import Adidas_Challenge

class ProductListServiceMock: ProductListServiceFetching {
    
    var dummyProductList = [
        Product(currency: "$", price: 100, id: "F144", name: "product 1", description: "description", imgUrl: "https://some.image.url.png",reviews: [Review(productId: "F144", locale: "en-US", rating: 4, text: "some review text")]),
        Product(currency: "$", price: 240, id: "F134", name: "product 2", description: "description", imgUrl: "https://some.image.url.png",reviews: [Review(productId: "F134", locale: "en-US", rating: 4, text: "some review text")])
    ]
    
    var invokedFetchProducts = false
    var invokedFetchProductsCount = 0
    func fetchProducts() -> Observable<[Product]> {
        invokedFetchProducts = true
        invokedFetchProductsCount += 1
        return .just(dummyProductList)
    }
}
