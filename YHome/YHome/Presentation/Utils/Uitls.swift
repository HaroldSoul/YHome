//
//  Uitls.swift
//  YHome
//
//  Created by kangho lee on 2023/02/26.
//

import Foundation

final class Utils {
    static let shared: Utils = Utils()
    
    private init(){}
    
    func currencyText(_ price: Int) -> String {
        guard price >= 10000 else {
            return String(price)
        }
        return String(format: "%d%@",price/10000, "만" )
    }
}
