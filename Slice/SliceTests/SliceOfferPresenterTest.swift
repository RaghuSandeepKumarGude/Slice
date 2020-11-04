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

class SliceOfferMockView: UIViewController {
    var isViewDidloadCalled = false
    var isOffersListFetchedCalled = false
    var offers = [[OffersInfo]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        isViewDidloadCalled = true
    }
}

extension SliceOfferMockView: PresenterToViewProtocol {
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
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    pushedViewController = viewController
    super.pushViewController(viewController, animated: true)
  }
}
