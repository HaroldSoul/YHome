//
//  HomeReactor.swift
//  YHome
//
//  Created by kangho lee on 2023/02/25.
//

import Foundation

import ReactorKit
import RxDataSources

final class HomeReactor: Reactor {
    enum Action {
        case fetch
    }
    
    enum Mutation {
        case resultData(data: [HomeSection])
        case alertErrorMessage(message: String)
    }
    
    struct State {
        var result: [HomeSection] = []
        var alertMessage: String = ""
    }
    
    var initialState: State = State()
    private var repository: HomeRepository
    
    init(repository: HomeRepository) {
        self.repository = repository
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .resultData(let data):
            state.result = data
            return state
        case .alertErrorMessage(let message):
            state.alertMessage = message
            return state
        }
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetch:
            return fetch()
        }
    }
}

extension HomeReactor {
    private func fetch() -> Observable<Mutation> {
        return Observable.create { [weak self] observer -> Disposable in
            self?.repository.fetchHomeData{ result in
                guard let dataResult = result else {
                    observer.onNext(.alertErrorMessage(message: "There is no data"))
                    observer.onCompleted()
                    return
                }
                
                let sectionData = dataResult.map {
                    switch $0 {
                    case .newEvent(let items):
                        return HomeSection(title: $0.title,
                                           keyword: $0.keyword,
                                           isMore: $0.isMore,
                                           items: items.map{ ItemReactor.recommand(ReCommandReactor($0)) })
                    case .recommand(let items):
                        return HomeSection(title: $0.title,
                                           keyword: $0.keyword,
                                           isMore: $0.isMore,
                                           items: items.map{ ItemReactor.recommand(ReCommandReactor($0)) })
                    case .ysTv(let items):
                        return HomeSection(title: $0.title,
                                           keyword: $0.keyword,
                                           isMore: $0.isMore,
                                           items: [ItemReactor.tv(TvReactor(items))])
                    }
                }
                observer.onNext(.resultData(data: sectionData))
                observer.onCompleted()
            }
            return Disposables.create()
        }
        
    }
    
}
