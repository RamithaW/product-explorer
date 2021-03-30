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

struct ProductDetailViewModelInputs {
    let footerButtonTapped = PublishSubject<Void>()
}

struct ProductDetailViewModelOutputs {
    let viewDismissed = PublishSubject<Void>()
    let showProductDetails = BehaviorSubject<Product?>(value: nil)
    let footerButtonTapped = PublishSubject<Product>()
}

class ProductDetailViewModel: ProductDetailViewModellable {

    let disposeBag = DisposeBag()
    let inputs = ProductDetailViewModelInputs()
    let outputs = ProductDetailViewModelOutputs()
    var useCase: ProductDetailInteractable
    let product: Product
    
    init(useCase: ProductDetailInteractable, product: Product) {
        self.product = product
        self.useCase = useCase
        outputs.showProductDetails.onNext(product)
        setupObservables()
    }
}

// MARK: - Observables

private extension ProductDetailViewModel {

    func setupObservables() {
        inputs.footerButtonTapped.map{ [weak self] in
            self?.product
        }.compactMap{ $0 }.bind(to: outputs.footerButtonTapped).disposed(by: disposeBag)
    }
}
