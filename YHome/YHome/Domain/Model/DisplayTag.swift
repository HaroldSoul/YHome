//
//  DisplayTagList.swift
//  YHome
//
//  Created by kangho lee on 2023/02/23.
//

import Foundation

struct DisplayTag: Codable {
    let tagName: String
    let tagLink: String
    let tagRank: Int
    let createAdminId: Int
    let updateAdminId: Int
    let createAt: String
    let updatedAt: String
}
