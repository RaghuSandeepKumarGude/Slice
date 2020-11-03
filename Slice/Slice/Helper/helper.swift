//
//  helper.swift
//  Slice
//
//  Created by Sandeep on 31/10/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var localHexString = hexString
        if localHexString.count == 3 || localHexString.count == 4 {
            localHexString = "#\(hexString.dropFirst().map { "\($0)\($0)" } .joined())"
        }
        let scanner             = Scanner(string: localHexString)
        let twoFiftyValue : CGFloat = 255.0
        let greenConstantCheck = 8
        let redConstantCheck = 16
        scanner.scanLocation    = 1
        var color: UInt32       = 0
        scanner.scanHexInt32(&color)
        let mask                = 0x000000FF
        let r                   = Int(color >> redConstantCheck) & mask
        let g                   = Int(color >> greenConstantCheck) & mask
        let b                   = Int(color) & mask
        let red                 = CGFloat(r) / twoFiftyValue
        let green               = CGFloat(g) / twoFiftyValue
        let blue                = CGFloat(b) / twoFiftyValue
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}


extension UIViewController {

func showToast(message : String) {
    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = .systemFont(ofSize: 12.0)
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }
