//
//  SliceOfferPresenterTest.swift
//  SliceTests
//
//  Created by Sandeep on 04/11/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import XCTest
@testable import Slice

class SliceOfferPresenterTest: XCTestCase {
    var presenter: SliceOfferPresenter!
    var view = SliceOfferMockView()
    var interactor = SliceOffersInteractorMock()
    var router = SliceOfferRouterMock()
    override func setUp() {
        presenter = SliceOfferPresenter()
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
    }
    
    override func tearDown() {
        presenter = nil
    }
    
    func testFetchOffersList() {
        presenter?.fetchOffersList()
        XCTAssertTrue(interactor.isFetchOffersCalled)
        XCTAssertTrue(view.isOffersListFetchedCalled)
        XCTAssertEqual(presenter.offersList.count, 1)
        XCTAssertEqual(presenter.offersList[0].count, 0)
    }
    
    func testShowOfferDetail() {
        let offer = OffersInfo(voucherCode: "voucherCode",
                               voucherDesc: "voucherDesc",
                               discountTitle: "discountTitle",
                               discountDesc: "discountDesc",
                               validTill: "validTill",
                               isExpiringSoon: true,
                               discount: "discount",
                               seller: "seller",
                               shareData: "shareData")
        presenter?.showOfferDetail(offer)
        XCTAssertTrue(router.isPresentToDetailScreenCalled)
    }
}
