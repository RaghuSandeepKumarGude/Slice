//
//  SliceOfferRouterTest.swift
//  SliceTests
//
//  Created by Sandeep on 04/11/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import XCTest
@testable import Slice

class SliceOfferRouterTest: XCTestCase {
    var router: SliceOfferRouter?
    var mockViewController = SliceOfferMockView()
    
    override func setUp() {
        router = SliceOfferRouter()
    }
    
    override func tearDown() {
        router = nil
    }
    
    func testCreateModule() {
        let module = SliceOfferRouter.createModule()
        XCTAssertNotNil(module.presenter)
        XCTAssertNotNil(module.presenter?.router)
        XCTAssertNotNil(module.presenter?.interactor)
        XCTAssertNotNil(module.presenter?.view)
    }
    
    func testPresentToDetailScreen() {
        let navigationController = MockNavigationController(rootViewController: mockViewController)
        UIApplication.shared.keyWindow?.rootViewController = navigationController
        
        let offer = OffersInfo(voucherCode: "voucherCode",
                               voucherDesc: "voucherDesc",
                               discountTitle: "discountTitle",
                               discountDesc: "discountDesc",
                               validTill: "validTill",
                               isExpiringSoon: true,
                               discount: "discount",
                               seller: "seller",
                               shareData: "shareData")
        router?.presentToDetailScreen(from: mockViewController,
                                      for: offer)
        XCTAssertNotNil(navigationController.pushedViewController)
        XCTAssertTrue(mockViewController.navigationController?.viewControllers.count ?? 0 > 0)
    }
}
