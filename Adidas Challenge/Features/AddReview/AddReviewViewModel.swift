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
    let addReviewTapped = PublishSubject<Void>()
}

struct AddReviewViewModelOutputs {}

class AddReviewViewModel: AddReviewViewModellable {

    let disposeBag = DisposeBag()
    let inputs = AddReviewViewModelInputs()
    let outputs = AddReviewViewModelOutputs()
    var useCase: AddReviewInteractable

    init(useCase: AddReviewInteractable) {
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
        inputs.addReviewTapped.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            Logger.info("Attempting to save review")
            
            self.useCase.saveReview(Review(productId: "FI444", locale: "en-US", rating: 4, text: "Testing from code")).subscribe(onNext: { _ in
                
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
}
