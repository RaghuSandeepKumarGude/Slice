//
//  OfferDetailsPresenterTest.swift
//  SliceTests
//
//  Created by Sandeep on 04/11/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import XCTest
@testable import Slice

class OfferDetailsPresenterTest : XCTestCase {
    var presenter: OfferDetailsPresenter!
    var view = mockOfferDetailView()
    var interactor = mockOfferDetailIntractor()
    var router = mockOfferDetailRouter()
    
    override func setUp() {
        presenter = OfferDetailsPresenter()
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
    }
    
    override func tearDown() {
        presenter = nil
    }
    
    func testFetchSelectedOffer() {
        presenter.fetchSelectedOffer()
        XCTAssertTrue(interactor.isfetchSelectedOfferCalled)
    }
    
    func testMoveToOffersView() {
        presenter.moveToOffersView()
        XCTAssertTrue(router.isNavigateBackToListViewControllerCalled)
    }
}

