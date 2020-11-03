//
//  BrandListCollectionViewCell.swift
//  Slice
//
//  Created by Sandeep on 31/10/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit

enum Seller: String {
    case swiggy
    case bookmyshow
    
    var sellerImage: UIImage {
        switch self {
        case .swiggy:
            return UIImage(named: "swiggy")!
        case .bookmyshow:
            return UIImage(named: "bookMyShow")!
        }
    }
}


class BrandListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var sellerImage: UIImageView!
    @IBOutlet weak var offerPercentage: UILabel!
    @IBOutlet weak var offerTitle: UILabel!
    @IBOutlet weak var offerBGView: UIView!
    @IBOutlet weak var sellerImageHolder: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = Constants.offerbannerCornerRadius
        sellerImageHolder.layer.cornerRadius = Constants.cornerRadius
        self.backgroundColor = .clear
        offerBGView.isHidden = true
        offerPercentage.textColor = .white
        offerTitle.textColor = .white
        offerBGView.layer.cornerRadius = Constants.cornerRadius
        offerBGView.backgroundColor = Constants.offerBackgroundColor
        offerBGView.alpha = 0.9
    }
    
    func updateProductInfo(product: OffersInfo?, index: Int) {
        guard let pro = product else {return}
        let offer = pro.discount?.replacingOccurrences(of: " OFF", with: "")
        offerBGView.isHidden = pro.discount?.isEmpty ?? true
        offerPercentage.text = offer
        offerTitle.text = "OFF"
        sellerImage.image = Seller(rawValue: product?.seller?.lowercased() ?? "")?.sellerImage
    }
}

