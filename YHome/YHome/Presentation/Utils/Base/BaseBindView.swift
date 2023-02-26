//
//  BaseBindView.swift
//  YHome
//
//  Created by kangho lee on 2023/02/26.
//

import UIKit

class BaseBindView<T>: BaseView {

    var model: T? {
        didSet {
            if let model = model {
                bind(model)
            }
        }
    }
    
    func bind(_ model: T) {}

}
