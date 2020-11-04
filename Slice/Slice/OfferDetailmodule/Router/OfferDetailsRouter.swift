//
//  OfferDetailsRouter.swift
//  Slice
//
//  Created by Sandeep on 01/11/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation
import UIKit

public class OfferDetailsRouter: OfferDetailRouterProtocol {
    
    func navigateBackToListViewController(from view: OfferDetailPresenterToViewProtocol) {
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid view protocol type")
        }
        viewVC.navigationController?.popViewController(animated: true)
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
     static func createOfferDetailRouterModule(with product: OffersInfo) -> OfferDetailViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "OfferDetailView") as! OfferDetailViewController
        let presenter: OfferDetailViewToPresenterProtocol & OfferDetailInteractorToPresenterProtocol = OfferDetailsPresenter()
        let interactor: OfferDetailPresenterToInteractorProtocol = OfferDetailsIntractor()
            interactor.selectedOffer = product
        let router: OfferDetailRouterProtocol = OfferDetailsRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
}
