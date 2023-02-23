//
//  UIView+Extension.swift
//  YHome
//
//  Created by kangho lee on 2023/02/24.
//

import Foundation
import UIKit

extension UIView {
    func round() {
        layer.cornerRadius = ((bounds.width < bounds.height) ? bounds.width: bounds.height) / 2
    }
}

