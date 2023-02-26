//
//  CellReactor.swift
//  YHome
//
//  Created by kangho lee on 2023/02/26.
//

import Foundation

import ReactorKit

final class ReCommandReactor: Reactor {
    
    enum Action { }
    
    struct State {
        var recommand: RecommendEvent
    }
    
    var initialState: State
    
    init(_ recommand: RecommendEvent) {
        initialState = State(recommand: recommand)
    }
}
