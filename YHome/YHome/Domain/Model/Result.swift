//
//  Result.swift
//  YHome
//
//  Created by kangho lee on 2023/02/25.
//

import Foundation


enum Result {
    case recommand([RecommendEvent])
    case ysTv([YsTv])
    case newEvent([RecommendEvent])
    
    
    var title: String {
        switch self {
        case .ysTv(_):
            return "여신TV 인기영상"
        case .recommand(_):
            return "추천"
        case .newEvent(_):
            return "신규"
        }
    }
    
    var keyword: String {
        switch self {
        case .ysTv(_):
            return ""
        case .recommand(_), .newEvent(_):
            return "이벤트"
        }
    }
    
    var isMore: Bool {
        switch self {
        case .ysTv(_):
            return true
        case .recommand(_), .newEvent(_):
            return false
        }
    }
}
