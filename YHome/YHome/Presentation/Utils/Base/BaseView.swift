//
//  BaseView.swift
//  YHome
//
//  Created by kangho lee on 2023/02/24.
//

import UIKit

class BaseView: UIView {

    init(){
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout(){}

}
