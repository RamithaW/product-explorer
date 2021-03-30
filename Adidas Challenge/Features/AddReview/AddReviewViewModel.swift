//
//  AddReviewViewModel.swift
//  ShiftOverview
//
//  Created Ramitha Wirasinha on 3/29/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import RxSwift

protocol AddReviewViewModellable: class {
    var disposeBag: DisposeBag { get }
    var inputs: AddReviewViewModelInputs { get }
    var outputs: AddReviewViewModelOutputs { get }
}

struct AddReviewViewModelInputs {
    let addReviewTapped = PublishSubject<String>()
}

struct AddReviewViewModelOutputs {
    let reviewAdded = PublishSubject<Void>()
}

class AddReviewViewModel: AddReviewViewModellable {

    let disposeBag = DisposeBag()
    let inputs = AddReviewViewModelInputs()
    let outputs = AddReviewViewModelOutputs()
    var useCase: AddReviewInteractable
    let product: Product
    
    init(useCase: AddReviewInteractable, product: Product) {
        self.product = product
        self.useCase = useCase
        setupObservables()
    }
}

// MARK: - Observables

private extension AddReviewViewModel {

    func setupObservables() {
        observeReviewAdding()
    }
    
    func observeReviewAdding() {
        inputs.addReviewTapped.subscribe(onNext: { [weak self] comment in
            guard let self = self else { return }
            
            Logger.info("Attempting to save review")
            
            // Currently hardcoding the rating, ideally I would implement stars so the user can tap to input
            self.useCase.saveReview(Review(productId: self.product.id, locale: "en-US", rating: 4, text: comment)).subscribe(onNext: { review in
                self.outputs.reviewAdded.onNext(())
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
}
