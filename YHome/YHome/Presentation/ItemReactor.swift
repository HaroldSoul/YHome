//
//  ItemReactor.swift
//  YHome
//
//  Created by kangho lee on 2023/02/26.
//

import Foundation

enum ItemReactor {
    case recommand(ReCommandReactor)
    case newEvent(ReCommandReactor)
    case tv(TvReactor)
}
