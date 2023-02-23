//
//  NetworkService.swift
//  YHome
//
//  Created by kangho lee on 2023/02/24.
//

import Foundation

import Alamofire

final class NetworkService {
    
    private(set) var session: Session!
    
    init(){
        self.session = Session(configuration: self.createSessionConfiguration())
    }
    
    private func createSessionConfiguration() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        return configuration
    }
    
    func responseJson<T: Decodable>(
        baseUrl: String,
        type: T.Type,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        complete: @escaping ((T? , Error?) -> Void))
    {
        
        let request = session.request(baseUrl,
                                      method: method,
                                      parameters: parameters)
        request.responseData { result in
            switch result.result {
            case .success(let resultData):
                do{
                    let responseData = try JSONDecoder().decode(T.self, from: resultData)
                    complete(responseData , nil)
                }catch{
                    print(error)
                }
                
            case .failure(let error):
                complete(nil, error)
            }
        }
    }
    
    
    func cancel(){
        self.session.session.getAllTasks { tasks in
            tasks.forEach { task in
                task.cancel()
            }
        }
    }
    
}
