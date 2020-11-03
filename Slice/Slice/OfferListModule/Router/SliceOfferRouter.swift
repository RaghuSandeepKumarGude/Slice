//
//  SliceOfferRouter.swift
//  Slice
//
//  Created by Sandeep on 31/10/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation
import UIKit

public class SliceOfferRouter: PresenterToRouterProtocol {
    static func createModule() -> SliceOfferViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "SliceOfferView") as! SliceOfferViewController
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = SliceOfferPresenter()
        let interactor: PresenterToInteractorProtocol = SliceOffersInteractor()
        let router:PresenterToRouterProtocol = SliceOfferRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }

    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func presentToDetailScreen(from view: PresenterToViewProtocol,
                                      for offer: OffersInfo) {
        let offerDetailsView = OfferDetailsRouter.createOfferDetailRouterModule(with: offer)
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid View Protocol type")
        }
        viewVC.navigationController?.pushViewController(offerDetailsView, animated: true)
    }
}
