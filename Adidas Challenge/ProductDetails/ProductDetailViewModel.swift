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
    let showProductDetails = BehaviorSubject<Product?>(value: nil)
}

class ProductDetailViewModel: ProductDetailViewModellable {

    let disposeBag = DisposeBag()
    let inputs = ProductDetailViewModelInputs()
    let outputs = ProductDetailViewModelOutputs()
    var useCase: ProductDetailInteractable

    init(useCase: ProductDetailInteractable, product: Product) {
        self.useCase = useCase
        outputs.showProductDetails.onNext(product)
        setupObservables()
    }
}

// MARK: - Observables

private extension ProductDetailViewModel {

    func setupObservables() {}
}
