//
//  TvReactor.swift
//  YHome
//
//  Created by kangho lee on 2023/02/26.
//

import Foundation
import ReactorKit

final class TvReactor: Reactor {
    
    enum Action { }
    
    struct State {
        var tvs: [YsTv]
    }
    
    var initialState: State
    
    init(_ tvs: [YsTv]) {
        initialState = State(tvs: tvs)
    }
}
