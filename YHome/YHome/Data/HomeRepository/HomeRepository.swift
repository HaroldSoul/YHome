//
//  HomeRepository.swift
//  YHome
//
//  Created by kangho lee on 2023/02/24.
//

import Foundation

final class HomeRepository {
    private let networkServie: NetworkService = NetworkService()
}

extension HomeRepository: HomeRepositoryUseCase {
    func fetchHomeData(complete: @escaping (([Result]?) -> Void)) {
        networkServie.responseJson(baseUrl: "https://f9c1a8f3-132d-451a-988f-47527dbda002.mock.pstmn.io/latest/ios2/product",
                                   type: HomeDataResult.self,
                                   method: .get){ result , error in
            guard let result = result?.results else {
                return
            }
            
            var dataResult: [Result] = []
            dataResult.append(Result.ysTv(result.ysTvList))
            dataResult.append(Result.recommand(result.recommendEventList))
            dataResult.append(Result.newEvent(result.newEventList))
            
            complete(dataResult)
        }
    }
    
    func cancel(){
        networkServie.cancel()
    }
}
