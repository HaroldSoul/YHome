//
//  DataResult.swift
//  YHome
//
//  Created by kangho lee on 2023/02/23.
//

import Foundation

struct DataResult: Codable {
    let bannerList: [Banner]
    let displayTagList: [DisplayTag]
    let recommendEventList: [RecommendEventList]
    let newEventList: [RecommendEventList]
    let ysTvList: [YsTv]
}
