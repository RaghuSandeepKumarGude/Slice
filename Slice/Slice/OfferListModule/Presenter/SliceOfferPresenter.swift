//
//  SliceOfferPresenter.swift
//  Slice
//
//  Created by Sandeep on 31/10/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation

class SliceOfferPresenter: ViewToPresenterProtocol {
    var offersList = [[OffersInfo]]()
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    weak var view:PresenterToViewProtocol?
    
    func fetchOffersList() {
        interactor?.fetchOffers()
    }
    
    func showOfferDetail(_ offer: OffersInfo) {
        guard let weakView = view else { return }
        router?.presentToDetailScreen(from: weakView, for: offer)
    }
}

extension SliceOfferPresenter: InteractorToPresenterProtocol {
    func offersListFetched(offers: [[OffersInfo]]) {
        self.offersList = offers
        view?.offersListFetched(offers: offers)
    }
}
