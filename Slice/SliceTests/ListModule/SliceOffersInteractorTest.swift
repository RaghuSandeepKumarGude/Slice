//
//  SliceOffersInteractorTest.swift
//  SliceTests
//
//  Created by Sandeep on 04/11/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import XCTest
@testable import Slice

class SliceOffersInteractorTest: XCTestCase {
    var interactor: SliceOffersInteractor?
    var presenter = SliceOfferPresenterMock()
    var mockDataManager = MockDataManager()
    override func setUp() {
        interactor = SliceOffersInteractor(apiservice: mockDataManager)
        interactor?.presenter = presenter
    }
    
    override func tearDown() {
        interactor = nil
    }
    
    func testFetchOffers() {
        interactor?.fetchOffers()
        XCTAssertTrue(presenter.isOffersListFetched)
        XCTAssertEqual(presenter.offers.count, 1)
        XCTAssertEqual(presenter.offers[0].count, 0)
    }
}
