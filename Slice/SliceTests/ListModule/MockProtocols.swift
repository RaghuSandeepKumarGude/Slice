//
//  MockProtocols.swift
//  SliceTests
//
//  Created by Sandeep on 04/11/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import XCTest
@testable import Slice

class SliceOfferMockView: UIViewController ,PresenterToViewProtocol {
    var isOffersListFetchedCalled = false
    var offers = [[OffersInfo]]()
    func offersListFetched(offers: [[OffersInfo]]) {
        self.offers = offers
        isOffersListFetchedCalled = true
    }
}

class SliceOffersInteractorMock:PresenterToInteractorProtocol {
    weak var presenter: InteractorToPresenterProtocol?
    var isFetchOffersCalled = false
    func fetchOffers() {
        presenter?.offersListFetched(offers: [[]])
        isFetchOffersCalled = true
    }
}

class SliceOfferRouterMock : PresenterToRouterProtocol {
    var isPresentToDetailScreenCalled = false
    static func createModule() -> SliceOfferViewController {
        return SliceOfferViewController()
    }
    
    func presentToDetailScreen(from view: PresenterToViewProtocol, for offer: OffersInfo) {
        isPresentToDetailScreenCalled = true
    }
}

class SliceOfferPresenterMock :InteractorToPresenterProtocol {
    var isOffersListFetched = false
    var offers = [[OffersInfo]]()
    func offersListFetched(offers: [[OffersInfo]]) {
        self.offers = offers
        isOffersListFetched = true
    }
}

class MockDataManager: DataManager {
    override func fetchOffersList(completion: @escaping CompletionHandler) {
        completion(nil, UrlError.noResultsFound)
    }
}

class MockNavigationController: UINavigationController {
  var pushedViewController: UIViewController?
    var isPopViewGotCalled = false
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    pushedViewController = viewController
    super.pushViewController(viewController, animated: true)
  }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        isPopViewGotCalled = true
        return UIViewController()
    }
}
