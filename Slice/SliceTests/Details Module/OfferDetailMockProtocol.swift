//
//  OfferDetailMockProtocol.swift
//  SliceTests
//
//  Created by Sandeep on 04/11/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import XCTest
@testable import Slice

class mockOfferDetailView: UIViewController, OfferDetailPresenterToViewProtocol {
    var isofferSelectedCalled = false
    func offerSelected(offer: OffersInfo?) {
        isofferSelectedCalled = true
    }
}

class mockOfferDetailIntractor: OfferDetailPresenterToInteractorProtocol {
    var presenter: OfferDetailInteractorToPresenterProtocol?
    var selectedOffer: OffersInfo?
    var isfetchSelectedOfferCalled = false
    func fetchSelectedOffer() {
        isfetchSelectedOfferCalled = true
    }
}

class mockOfferDetailRouter: OfferDetailRouterProtocol {
    var isNavigateBackToListViewControllerCalled = false
    static func createOfferDetailRouterModule(with product: OffersInfo) -> OfferDetailViewController {
        return OfferDetailViewController()
    }
    
    func navigateBackToListViewController(from view: OfferDetailPresenterToViewProtocol) {
        isNavigateBackToListViewControllerCalled = true
    }
}

class mockOfferDetailsPresenter: OfferDetailInteractorToPresenterProtocol {
    var isOfferSelectedCalled = false
    func offerSelected(offer: OffersInfo?) {
        isOfferSelectedCalled = true
    }
}
