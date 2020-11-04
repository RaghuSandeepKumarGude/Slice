//
//  OfferDetailViewController.swift
//  Slice
//
//  Created by Sandeep on 01/11/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit

class OfferDetailViewController: UIViewController {
    var presenter: OfferDetailViewToPresenterProtocol?
    var selectedOffer: OffersInfo?
    @IBOutlet weak var offerImageHolder: UIImageView!
    @IBOutlet weak var sellerImage: UIImageView!
    @IBOutlet weak var topGradient: UIView!
    @IBOutlet weak var bottomGradient: UIView!
    @IBOutlet weak var backArrowHeader: UILabel!
    @IBOutlet weak var offerAmount: UILabel!
    @IBOutlet weak var offerDescription: UILabel!
    
    @IBOutlet weak var vocherHeader: UILabel!
    @IBOutlet weak var vocherCode: UILabel!
    @IBOutlet weak var vocherDesc: UILabel!
    @IBOutlet weak var vocherValidity: UILabel!
    
    @IBOutlet weak var copyVocherCode: UIButton!
    @IBOutlet weak var offerExpiresView: UIButton!
    @IBOutlet weak var sahreInfo: UIButton!
    
    @IBOutlet weak var sellerImageHolder: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topShadow = UIImage(named: "topGradient") {
            UIGraphicsBeginImageContext(topGradient.frame.size)
            topShadow.draw(in: topGradient.bounds)
            if let topImage = UIGraphicsGetImageFromCurrentImageContext(){
                UIGraphicsEndImageContext()
                topGradient.backgroundColor = UIColor(patternImage: topImage)
            }
        }
        
        if let bottomShadow = UIImage(named: "bottomGradient") {
            UIGraphicsBeginImageContext(bottomGradient.frame.size)
            bottomShadow.draw(in: bottomGradient.bounds)
            if let bottomImage = UIGraphicsGetImageFromCurrentImageContext(){
                UIGraphicsEndImageContext()
                bottomGradient.backgroundColor = UIColor(patternImage: bottomImage)
            }
        }
        presenter?.fetchSelectedOffer()
        updateUIElements()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    private func updateUIElements() {
        
        offerImageHolder.roundCorners(cornerRadius: Double(2*Constants.offerbannerCornerRadius), corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner])
        bottomGradient.roundCorners(cornerRadius: Double(2*Constants.offerbannerCornerRadius), corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner])
        
        
        backArrowHeader.text = "top offers"
        backArrowHeader.textColor = .white
        backArrowHeader.font = UIFont(name: "HelveticaNeue", size: 20)
        
        offerAmount.textColor = .white
        offerAmount.font = UIFont(name: "HelveticaNeue-bold", size: 24)
        offerAmount.textAlignment = .left
        
        offerDescription.textColor = .white
        offerDescription.font = UIFont(name: "HelveticaNeue", size: 16)
        offerDescription.textAlignment = .left
        sellerImageHolder.layer.cornerRadius = Constants.cornerRadius
        vocherHeader.textColor = UIColor(hexString: "#37305E")
        vocherHeader.font = UIFont(name: "HelveticaNeue", size: 16)
        vocherHeader.alpha = 0.7
        vocherHeader.textAlignment = .left
        
        vocherCode.textColor =  UIColor(hexString: "#37305E")
        vocherCode.font = UIFont(name: "HelveticaNeue", size: 25)
        vocherCode.textAlignment = .left
        
        vocherDesc.textColor =  UIColor(hexString: "#37305E")
        vocherDesc.font = UIFont(name: "HelveticaNeue", size: 16)
        vocherDesc.textAlignment = .left
        
        vocherValidity.textColor =  UIColor(hexString: "#37305E")
        vocherValidity.alpha = 0.7
        vocherValidity.font = UIFont(name: "HelveticaNeue", size: 16)
        vocherValidity.textAlignment = .left
        
        offerExpiresView.backgroundColor = UIColor(hexString: "#FF8500")
        let expiresIcon = UIImage(named: "expiresSoonIcon")
        offerExpiresView.setImage(expiresIcon, for: .normal)
        offerExpiresView.setTitle("expires soon", for: .normal)
        offerExpiresView.setTitleColor(.white, for: .normal)
        offerExpiresView.imageEdgeInsets = addEdgeInsert()
        offerExpiresView.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 16)
        offerExpiresView.roundCorners(cornerRadius: 8, corners: [.layerMinXMaxYCorner,
                                                                 .layerMaxXMaxYCorner])
    }
    
    private func addEdgeInsert() -> UIEdgeInsets {
        return UIEdgeInsets(top: 0,
                            left: 0,
                            bottom: 0,
                            right: 13)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
    
    func reloadView() {
        offerAmount.text = selectedOffer?.discountTitle
        offerDescription.text = selectedOffer?.discountDesc
        
        vocherHeader.text = "voucher code:"
        vocherCode.text = selectedOffer?.voucherCode
        vocherDesc.text = selectedOffer?.voucherDesc
        vocherValidity.text = selectedOffer?.validTill
        offerExpiresView.isHidden = !(selectedOffer?.isExpiringSoon  ?? true)
        sellerImage.image = Seller(rawValue: selectedOffer?.seller?.lowercased() ?? "")?.sellerImage
    }
    
    @IBAction func navigateBack() {
        presenter?.moveToOffersView()
    }
    
    @IBAction func copyCoupoCode() {
        
        guard let _ = selectedOffer?.voucherCode else {return}
        let pasteboard = UIPasteboard.general
        pasteboard.string = selectedOffer?.voucherCode
        self.showToast(message: "Vocher copied")
    }
    
    @IBAction func shareOfferDetails() {
        guard let text = selectedOffer?.shareData else {return}
        let textShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textShare,
                                                              applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}

extension OfferDetailViewController: OfferDetailPresenterToViewProtocol {
    func offerSelected(offer: OffersInfo?) {
        selectedOffer = offer
        self.reloadView()
    }
}

extension UIView {
    func roundCorners(cornerRadius: Double, corners: CACornerMask) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
        self.layer.maskedCorners = corners
    }
}
