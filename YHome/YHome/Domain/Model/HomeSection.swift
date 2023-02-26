//
//  HomeSection.swift
//  YHome
//
//  Created by kangho lee on 2023/02/26.
//

import Foundation
import RxDataSources

struct HomeSection {
    var title: String
    var keyword: String
    var isMore: Bool
    var items: [ItemReactor]
}

extension HomeSection: SectionModelType {
    typealias Item = ItemReactor
    
    init(original: HomeSection, items: [ItemReactor]) {
        self = original
        self.items = items
    }
}

enum SectionGroup: Int {
    case tv = 0
    case recommand = 1
    case newEvent = 2
}
