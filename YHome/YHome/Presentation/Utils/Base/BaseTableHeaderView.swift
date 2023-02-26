//
//  BaseTableHeaderView.swift
//  YHome
//
//  Created by kangho lee on 2023/02/26.
//

import UIKit

class BaseTableHeaderView<T>: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
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
