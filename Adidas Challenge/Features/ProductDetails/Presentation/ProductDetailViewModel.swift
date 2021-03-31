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
    let reloadProductDetails = PublishSubject<Void>()
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
        
        inputs.reloadProductDetails.subscribe { [weak self] _ in
            guard let self = self else { return }
            Logger.info("Attempting to fetch product details for: \(self.product.id)")
            self.useCase.fetchProductDetails(self.product.id).subscribe(onNext: { (product) in
                Logger.info("Fetched product details")
                self.outputs.showProductDetails.onNext(product)
            }, onError: { (error) in
                Logger.error("Error fetching product details for \(self.product.id)")
            }).disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
    }
}
