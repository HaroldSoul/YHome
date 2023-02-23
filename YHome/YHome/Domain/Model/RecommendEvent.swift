//
//  RecommendEventList.swift
//  YHome
//
//  Created by kangho lee on 2023/02/23.
//

import Foundation

struct RecommendEventList: Codable {
    let name: String
    let comment: String
    let customerName: String
    let displayName: String
    let price: Int
    let currencyName: String
    let customerCode: String
    let score: Int
    let cpmBudgetScore: String
    let locationName: String
    let productCode: String
    let wishCount: Int
    let reviewCount: Int
    let rateScore: Int
    let distance: Int
    let wishIcon: String
    let thumbnailImageUrl: String
    let detailLinkUrl: String
    let reservationYn: String   
}
