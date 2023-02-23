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
    func fetchHomeData(complete: @escaping ((DataResult?) -> Void)) {
        networkServie.responseJson(baseUrl: "https://f9c1a8f3-132d-451a-988f-47527dbda002.mock.pstmn.io/latest/ios2/product",
                                   type: HomeDataResult.self,
                                   method: .get){ result , error in
            guard let result = result else {
                print(error)
                return
            }
            complete(result.results)
        }
    }
    
    func cancel(){
        networkServie.cancel()
    }
}
