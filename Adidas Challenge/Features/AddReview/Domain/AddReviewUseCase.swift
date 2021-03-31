//
//  AddReviewUseCase.swift
//  ShiftOverview
//
//  Created Ramitha Wirasinha on 3/29/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import RxSwift

public protocol AddReviewInteractable {
    func saveReview(_ review: Review) -> Observable<Review>
}

class AddReviewUseCase: AddReviewInteractable {

    private let service: AddReviewServicePerforming
    
    init(service: AddReviewServicePerforming) {
        self.service = service
    }
    
    func saveReview(_ review: Review) -> Observable<Review> {
        return service.saveReview(review: review)
    }
}
