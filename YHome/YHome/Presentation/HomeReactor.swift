//
//  HomeReactor.swift
//  YHome
//
//  Created by kangho lee on 2023/02/25.
//

import Foundation

import ReactorKit

final class HomeReactor: Reactor {
    enum Action {
        case fetch
    }
    
    enum Mutation {
        case resultData(data: DataResult?)
        case alertErrorMessage(message: String)
    }
    
    struct State {
        var result: DataResult?
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
                
                observer.onNext(.resultData(data: dataResult))
                observer.onCompleted()
            }
            return Disposables.create()
        }
        
    }
    
}
