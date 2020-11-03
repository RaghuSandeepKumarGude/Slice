//
//  OfferDetailsPresenter.swift
//  Slice
//
//  Created by Sandeep on 01/11/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation

class OfferDetailsPresenter: OfferDetailViewToPresenterProtocol {
    
    weak var view: OfferDetailPresenterToViewProtocol?
    var interactor: OfferDetailPresenterToInteractorProtocol?
    var router: OfferDetailRouterProtocol?
    
    func fetchSelectedOffer() {
        interactor?.fetchSelectedOffer()
    }
    
    func moveToOffersView() {
        if let weakView = view {
            router?.navigateBackToListViewController(from: weakView)
        }
    }
}

extension OfferDetailsPresenter: OfferDetailInteractorToPresenterProtocol {
    func offerSelected(offer: OffersInfo?) {
        view?.offerSelected(offer: offer)
    }
}
