//
//  SliceOfferProtocols.swift
//  Slice
//
//  Created by Sandeep on 31/10/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation

protocol ViewToPresenterProtocol: class{
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func fetchOffersList()
    func showOfferDetail(_ offer: OffersInfo)
}

protocol PresenterToViewProtocol: class {
    func offersListFetched(offers: [[OffersInfo]])
}

protocol PresenterToInteractorProtocol: class {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchOffers()
}

protocol PresenterToRouterProtocol: class {
    static func createModule() -> SliceOfferViewController
    func presentToDetailScreen(from view: PresenterToViewProtocol, for offer: OffersInfo)
}

protocol InteractorToPresenterProtocol: class {
    func offersListFetched(offers: [[OffersInfo]])
}
