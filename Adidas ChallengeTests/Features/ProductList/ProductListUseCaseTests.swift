//
//  ProductListUseCaseTests.swift
//  Adidas ChallengeTests
//
//  Created by Ramitha Wirasinha on 3/31/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import XCTest
import RxSwift
@testable import Adidas_Challenge

// Due to time constraints, I'm writing only a few tests, but this can be repeated to the remaining features/classes to increase coverage
class ProductListUseCaseTests: XCTestCase {

    private let productListServiceMock = ProductListServiceMock()
    private var sut: ProductListUseCase!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        sut = ProductListUseCase(service: productListServiceMock)
        disposeBag = DisposeBag()
    }

    func testFetchingProducts() {
        sut.fetchProducts().subscribe(onNext: { [weak self] (product) in
            XCTAssertTrue(self?.productListServiceMock.invokedFetchProducts ?? false)
            XCTAssertEqual(self?.productListServiceMock.invokedFetchProductsCount, 1)
        }).disposed(by: disposeBag)
    }
}
