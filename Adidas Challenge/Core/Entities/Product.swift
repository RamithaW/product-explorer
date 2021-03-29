//
//  Product.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/28/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import Foundation

public struct Product: Codable, Hashable {
    
    public static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
    
    let currency: String
    let price: Int
    let id: String
    let name: String
    let description: String
    let imgUrl: String
    let reviews: [Review]
}
