//
//  ProductListViewModelTests.swift
//  Adidas ChallengeTests
//
//  Created by Ramitha Wirasinha on 3/30/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

@testable import Adidas_Challenge

// Due to time constraints, I'm writing only a few tests, but this can be repeated to the remaining features/classes to increase coverage
class ProductListViewModelTests: XCTestCase {
    
    private let productListUseCaseMock = ProductListUseCaseMock()
    private var sut: ProductListViewModel!
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!
    
    override func setUpWithError() throws {
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        sut = ProductListViewModel(useCase: productListUseCaseMock)
    }
    
    func testFetchingProducts() {
        // when
        sut.inputs.loadData.onNext(())
        
        // then
        XCTAssertEqual(productListUseCaseMock.invokedFetchProducts, true)
        XCTAssertEqual(productListUseCaseMock.invokedFetchProductsCount, 1)
    }
    
    func testShowProductDetails() {
        // given
        let expectedProductToBeSelected = Product(currency: "$", price: 240, id: "F134", name: "product 2", description: "description", imgUrl: "https://some.image.url.png", reviews: [Review(productId: "F134", locale: "en-US", rating: 4, text: "some review text")])
        sut.inputs.loadData.onNext(())
            
        let selectedProduct = scheduler.createObserver(Product.self)
        sut.outputs.showProductDetails.bind(to: selectedProduct).disposed(by: disposeBag)
        
        // when
        scheduler.createColdObservable([.next(0, 1)])
            .bind(to: sut.inputs.tappedItemAtIndex)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        // then
        XCTAssertEqual(selectedProduct.events, [.next(0, expectedProductToBeSelected)])
    }
}
