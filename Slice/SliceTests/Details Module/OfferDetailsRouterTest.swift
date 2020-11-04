//
//  OfferDetailsRouterTest.swift
//  SliceTests
//
//  Created by Sandeep on 04/11/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import XCTest
@testable import Slice

class OfferDetailsRouterTest: XCTestCase {
    var router: OfferDetailsRouter?
    var mockView = mockOfferDetailView()
    override func setUp() {
        router = OfferDetailsRouter()
    }
    
    override func tearDown() {
        router = nil
    }
    
    func testNavigateBackToListViewController() {
        let navigationController = MockNavigationController(rootViewController: mockView)
        UIApplication.shared.keyWindow?.rootViewController = navigationController
        
        router?.navigateBackToListViewController(from: mockView)
        XCTAssertTrue(navigationController.isPopViewGotCalled)
    }
    
    func testCreateOfferDetailRouterModule() {
        let offer = OffersInfo(voucherCode: "voucherCode",
                               voucherDesc: "voucherDesc",
                               discountTitle: "discountTitle",
                               discountDesc: "discountDesc",
                               validTill: "validTill",
                               isExpiringSoon: true,
                               discount: "discount",
                               seller: "seller",
                               shareData: "shareData")
        let module = OfferDetailsRouter.createOfferDetailRouterModule(with: offer)
        XCTAssertNotNil(module.presenter)
        XCTAssertNotNil(module.presenter?.router)
        XCTAssertNotNil(module.presenter?.interactor)
        XCTAssertNotNil(module.presenter?.view)
        if let selectedOffer = module.presenter?.interactor?.selectedOffer {
            XCTAssertEqual(selectedOffer.voucherCode, offer.voucherCode)
            XCTAssertEqual(selectedOffer.voucherDesc, offer.voucherDesc)
            XCTAssertEqual(selectedOffer.discountTitle, offer.discountTitle)
            XCTAssertEqual(selectedOffer.discountDesc, offer.discountDesc)
            XCTAssertEqual(selectedOffer.validTill, offer.validTill)
            XCTAssertEqual(selectedOffer.isExpiringSoon, offer.isExpiringSoon)
            XCTAssertEqual(selectedOffer.discount, offer.discount)
            XCTAssertEqual(selectedOffer.seller, offer.seller)
            XCTAssertEqual(selectedOffer.shareData, offer.shareData)
        } else {
            XCTFail("testCreateOfferDetailRouterModule_ failed")
        }
    }
}
