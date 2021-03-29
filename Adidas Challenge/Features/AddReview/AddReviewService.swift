//
//  AddReviewService.swift
//  ShiftOverview
//
//  Created Ramitha Wirasinha on 3/29/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import RxSwift


public protocol AddReviewServicePerforming {
    func saveReview(review: Review) -> Observable<Review>
}

class AddReviewService: AddReviewServicePerforming {
    
    private let client: HTTPClientType
    
    public init(client: HTTPClientType) {
        self.client = client
    }
    
    func saveReview(review: Review) -> Observable<Review> {
        Logger.debug("Saving review")
        return client.request(ApiRouter.saveReview(review: review))
    }
}
