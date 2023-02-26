//
//  BaseCollectionCell.swift
//  YHome
//
//  Created by kangho lee on 2023/02/26.
//

import Foundation
import UIKit


class BaseCollectionCell<T>: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: T? {
        didSet {
            if let model = model {
                bind(model)
            }
        }
    }
    
    func setLayout() {}
    func bind(_ model: T) {}
}
