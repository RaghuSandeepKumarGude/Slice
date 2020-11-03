//
//  OfferDetailsCollectionViewCell.swift
//  Slice
//
//  Created by Sandeep on 31/10/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit

protocol offerCellProtocol: class {
    func selectedItem(at Index: IndexPath, atRow: Int)
}

class OfferDetailsCollectionViewCell: UICollectionViewCell {
    weak var offerCellDelegate:offerCellProtocol?
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    var offerDetails: [OffersInfo]? {
           didSet{
            brandsCollectionView.reloadData()
           }
       }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        setupCollectionView()
        
        
    }
    
    private func setupCollectionView() {
        brandsCollectionView?.delegate = self
        brandsCollectionView?.dataSource = self
        brandsCollectionView?.backgroundView = nil
        brandsCollectionView?.backgroundColor = .clear

        brandsCollectionView?.register(UINib.init(nibName: Constants.BrandListCVC,
                                                     bundle: nil),
                                          forCellWithReuseIdentifier: Constants.BrandListCVCID)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: 24,
                                           bottom: 0,
                                           right: 24)
        layout.minimumInteritemSpacing = Constants.edges
        layout.minimumLineSpacing = Constants.edges
        brandsCollectionView?.collectionViewLayout = layout
    }
}

extension OfferDetailsCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return offerDetails?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.BrandListCVCID,
                                                      for: indexPath) as! BrandListCollectionViewCell
        cell.updateProductInfo(product: offerDetails?[indexPath.row],
                               index: indexPath.row)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.BrandListCellWidth,
                      height: Constants.BrandListCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        offerCellDelegate?.selectedItem(at: indexPath, atRow: self.tag)
    }
}
