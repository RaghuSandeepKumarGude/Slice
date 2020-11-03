//
//  SliceOfferIntractor.swift
//  Slice
//
//  Created by Sandeep on 31/10/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation

class SliceOffersInteractor: PresenterToInteractorProtocol {
    private var apiservice = DataManager()
    weak var presenter: InteractorToPresenterProtocol?
    
    func fetchOffers() {
        apiservice.fetchOffersList { [weak self] (response, error) in
            guard let weakSelf = self else {return}
            weakSelf.presenter?.offersListFetched(offers: response?.data ?? [[]])
        }
    }
}

enum UrlError: Error {
    case invalidUrl
    case noResultsFound
}

typealias  CompletionHandler = (OffersData?, Error?) -> Void
private var baseURL = "ResponseData"

class DataManager {
    func fetchOffersList(completion: @escaping CompletionHandler) {
        guard let actualURL = Bundle.main.url(forResource: baseURL,
                                              withExtension: "json") else {
            completion(nil, UrlError.invalidUrl)
            return
        }
        do {
            let data = try Data(contentsOf: actualURL)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(OffersData.self, from: data)
            completion(jsonData, nil)
        } catch let errorValue {
            completion(nil, errorValue)
        }
    }
}
