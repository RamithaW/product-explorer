//
//  Review.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/28/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import Foundation

public struct Review: Codable, Hashable {
    
    public static func == (lhs: Review, rhs: Review) -> Bool {
        return lhs.productId == rhs.productId &&
            lhs.locale == rhs.locale &&
            lhs.rating == rhs.rating &&
            lhs.text == rhs.text
    }
    
    let productId: String
    let locale: String
    let rating: Int
    let text: String
}
