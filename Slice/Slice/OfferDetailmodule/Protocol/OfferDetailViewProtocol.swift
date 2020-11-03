//
//  OfferDetailViewProtocol.swift
//  Slice
//
//  Created by Sandeep on 01/11/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit
import Foundation

protocol OfferDetailRouterProtocol: class {
    static func createOfferDetailRouterModule(with product: OffersInfo) -> UIViewController
    func navigateBackToListViewController(from view: OfferDetailPresenterToViewProtocol)
}

protocol OfferDetailViewToPresenterProtocol: class{
    var view: OfferDetailPresenterToViewProtocol? {get set}
    var interactor: OfferDetailPresenterToInteractorProtocol? {get set}
    var router: OfferDetailRouterProtocol? {get set}
    func fetchSelectedOffer()
    func moveToOffersView()
}

protocol OfferDetailPresenterToViewProtocol: class {
    func offerSelected(offer: OffersInfo?)
}

protocol OfferDetailPresenterToInteractorProtocol: class {
    var presenter:OfferDetailInteractorToPresenterProtocol? {get set}
    var selectedOffer: OffersInfo? { get set }
    func fetchSelectedOffer()
}

protocol OfferDetailInteractorToPresenterProtocol: class {
    func offerSelected(offer: OffersInfo?)
}
