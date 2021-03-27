//
//  ProductListService.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/27/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import RxSwift

public protocol ProductListServiceFetching {
}

class ProductListService: ProductListServiceFetching {
    
    private let client: NSObject
    private let serviceErrorListener: NSObject
    
    public init(client: NSObject, serviceErrorListener: NSObject) {
        self.client = client
        self.serviceErrorListener = serviceErrorListener
    }
}
