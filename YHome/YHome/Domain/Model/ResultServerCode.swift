//
//  ResultServerCode.swift
//  YHome
//
//  Created by kangho lee on 2023/02/23.
//

import Foundation

enum ResultServerCode: String, Decodable {
    case sucess
    case fail
    
    init(from decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: ResultCodingKey.self)
        
        self = ResultServerCode(rawValue: try container.decodeIfPresent(String.self,
                                                                        forKey: .serverCode) ?? "") ?? ResultServerCode.fail
    }
    
    enum ResultCodingKey: CodingKey {
        case serverCode
    }
}
