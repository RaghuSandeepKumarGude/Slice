//
//  Entity.swift
//  Slice
//
//  Created by Sandeep on 31/10/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import Foundation

struct OffersData: Codable {
    let data: [[OffersInfo]]?
}

struct OffersInfo: Codable {
    let voucherCode, voucherDesc, discountTitle, discountDesc: String?
    let validTill: String?
    let isExpiringSoon: Bool?
    let discount, seller, shareData, voucherImage: String?
}
