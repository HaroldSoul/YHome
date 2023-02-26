//
//  HomeRepositoryUseCase.swift
//  YHome
//
//  Created by kangho lee on 2023/02/24.
//

import Foundation

protocol HomeRepositoryUseCase: AnyObject {
    func fetchHomeData(complete: @escaping (([Result]?) -> Void))
    func cancel()
}
