//
//  DetailReactor.swift
//  YHome
//
//  Created by kangho lee on 2023/02/26.
//

import Foundation

import ReactorKit

final class DetailReactor: Reactor {
    
    enum Action {
        
    }
    
    struct State {
        var recommand: ReCommandReactor?
        var tv: TvReactor?
    }
    
    var initialState: State
    
    init(recommand: ReCommandReactor){
        initialState = State(recommand: recommand)
    }
    
    init(tv: TvReactor){
        initialState = State(tv: tv)
    }
}
