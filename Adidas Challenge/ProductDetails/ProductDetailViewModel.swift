//
//  ProductDetailViewModel.swift
//  JobPage
//
//  Created Ramitha Wirasinha on 3/29/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import RxSwift

protocol ProductDetailViewModellable: class {
    var disposeBag: DisposeBag { get }
    var inputs: ProductDetailViewModelInputs { get }
    var outputs: ProductDetailViewModelOutputs { get }
}

struct ProductDetailViewModelInputs {}

struct ProductDetailViewModelOutputs {
    let viewDismissed = PublishSubject<Void>()
}

class ProductDetailViewModel: ProductDetailViewModellable {

    let disposeBag = DisposeBag()
    let inputs = ProductDetailViewModelInputs()
    let outputs = ProductDetailViewModelOutputs()
    var useCase: ProductDetailInteractable

    init(useCase: ProductDetailInteractable) {
        self.useCase = useCase
    }
}

// MARK: - Observables

private extension ProductDetailViewModel {

    func setupObservables() {}
}
