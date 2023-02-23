//
//  HomeDataResult.swift
//  YHome
//
//  Created by kangho lee on 2023/02/23.
//

import Foundation

struct HomeDataResult: Decodable {
    let serverCode: String
    let results: DataResult
}
