//
//  ProductListService.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/27/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import RxSwift

public struct Product {
    var name = "Levis Jeans"
}

public protocol ProductListServiceFetching {
    func fetchProducts() -> Observable<[Product]>
}

class ProductListService: ProductListServiceFetching {
    
    private let client: NSObject
    private let serviceErrorListener: NSObject
    
    public init(client: NSObject, serviceErrorListener: NSObject) {
        self.client = client
        self.serviceErrorListener = serviceErrorListener
    }
    
    func fetchProducts() -> Observable<[Product]> {
        return Observable.create { observer in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                observer.onNext([Product(), Product()])
            }
            return Disposables.create()
        }
    }
}
