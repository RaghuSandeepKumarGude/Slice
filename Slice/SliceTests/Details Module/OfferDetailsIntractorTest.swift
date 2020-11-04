//
//  OfferDetailsIntractorTest.swift
//  SliceTests
//
//  Created by Sandeep on 04/11/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import XCTest
@testable import Slice

class OfferDetailsIntractorTest : XCTestCase {
    
    var interactor: OfferDetailsIntractor?
    var presenter = mockOfferDetailsPresenter()
    
    override func setUp() {
        interactor = OfferDetailsIntractor()
        interactor?.presenter = presenter
    }
    
    override func tearDown() {
        interactor = nil
    }
    
    func testFetchSelectedOffer() {
        interactor?.fetchSelectedOffer()
        XCTAssertTrue(presenter.isOfferSelectedCalled)
    }
    
}
