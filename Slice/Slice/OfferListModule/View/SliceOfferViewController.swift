//
//  ViewController.swift
//  Slice
//
//  Created by Sandeep on 31/10/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit

class SliceOfferViewController: UIViewController {
    var presenter:ViewToPresenterProtocol?
    @IBOutlet weak var offersListCollectionView: UICollectionView!
    var offersList = [[OffersInfo]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchOffersList()
        setupCollectionView()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateNavigationProperties()
        self.view.backgroundColor =  UIColor(hexString: "#E5E5E5")
    }
    
    func updateNavigationProperties() {
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "#E5E5E5")
        self.title = ""
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        let shadowView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: (self.navigationController?.navigationBar.bounds.width)!,
                                              height: (self.navigationController?.navigationBar.bounds.height)! + 40))
        shadowView.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.insertSubview(shadowView, at: 1)
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: shadowView.bounds,
                                        byRoundingCorners: [.bottomLeft , .bottomRight],
                                        cornerRadii: CGSize(width: 10, height: 10)).cgPath
        
        shadowLayer.fillColor = UIColor(hexString: "#37305E").cgColor
        
        shadowLayer.shadowColor = UIColor.clear.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        shadowLayer.shadowOpacity = 0.8
        shadowLayer.shadowRadius = 2
        shadowView.layer.insertSublayer(shadowLayer, at: 0)
        
        let margin :CGFloat = 20
        
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.frame = CGRect(x: margin, y: 0, width: 100, height: shadowView.frame.size.height)
        label.font = UIFont(name: "HelveticaNeue", size: 24)
        label.text = "hi there!"
        shadowView.addSubview(label)
        
        let userProfile = UIImage(named: "User")
        let userWidth = userProfile?.size.width ?? 50
        let loginBtn = UIButton(type: .custom)
        loginBtn.frame = CGRect(x: shadowView.frame.size.width - (userWidth + margin),
                                y: 0,
                                width: userWidth,
                                height: shadowView.frame.size.height)
        
        loginBtn.setImage(userProfile, for: .normal)
        shadowView.addSubview(loginBtn)
    }
    
    private func setupCollectionView() {
        offersListCollectionView?.delegate = self
        offersListCollectionView?.dataSource = self
        offersListCollectionView?.backgroundView = nil
        offersListCollectionView?.backgroundColor = .clear
        
        offersListCollectionView?.register(UINib.init(nibName: Constants.OfferDetailsCVC,
                                                     bundle: nil),
                                          forCellWithReuseIdentifier: Constants.OfferDetailsCVCID)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = Constants.edges
        layout.minimumLineSpacing = Constants.edges
        offersListCollectionView?.collectionViewLayout = layout
    }
}

extension SliceOfferViewController: PresenterToViewProtocol {
    func offersListFetched(offers: [[OffersInfo]]) {
        self.offersList = offers
        offersListCollectionView.reloadData()
    }
}

extension SliceOfferViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.OfferDetailsCVCID,
                                                      for: indexPath) as! OfferDetailsCollectionViewCell
        cell.offerDetails = offersList[indexPath.row]
        cell.offerCellDelegate = self
        cell.tag = indexPath.row
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width,
                      height: Constants.eachItemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
             let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderID", for: indexPath) as! SectionHeader
            sectionHeader.backgroundColor = .white
            sectionHeader.updateSectionHeader()
             return sectionHeader
        } else { //No footer in this case but can add option for that
             return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        var sectionHeight: CGFloat = 0
        if section == 0 {
            sectionHeight = 60
        }
        return CGSize(width: collectionView.frame.size.width,
                      height: sectionHeight)
    }
}
extension SliceOfferViewController: offerCellProtocol {
    func selectedItem(at Index: IndexPath, atRow: Int) {
        let selected = offersList[atRow][Index.row]
        presenter?.showOfferDetail(selected)
    }
}

class SectionHeader: UICollectionReusableView {
//    SectionHeaderID
    @IBOutlet weak var sectionHeader: UIButton!
    
    func updateSectionHeader() {
        sectionHeader.titleEdgeInsets = addEdgeInsert()
        sectionHeader.setTitleColor(.black, for: .normal)
        sectionHeader.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 24)
        sectionHeader.setImage(#imageLiteral(resourceName: "offerIcon"), for: .normal)
        sectionHeader.setTitle("Top offers", for: .normal)
    }
    
    private func addEdgeInsert() -> UIEdgeInsets {
        return UIEdgeInsets(top: 0,
                            left: 8,
                            bottom: 0,
                            right: 0)
    }
}

