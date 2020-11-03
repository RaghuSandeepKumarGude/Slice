//
//  OfferDetailsIntractor.swift
//  Slice
//
//  Created by Sandeep on 01/11/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation

class OfferDetailsIntractor: OfferDetailPresenterToInteractorProtocol {
    weak var presenter: OfferDetailInteractorToPresenterProtocol?
    var selectedOffer: OffersInfo?
    
    func fetchSelectedOffer() {
        presenter?.offerSelected(offer: selectedOffer)
    }
}
