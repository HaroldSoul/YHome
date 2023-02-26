//
//  UIView+Extension.swift
//  YHome
//
//  Created by kangho lee on 2023/02/24.
//

import Foundation
import UIKit

extension UIView {
    func round(_ rad: CGFloat = 0) {
        layer.cornerRadius = rad == 0 ? ((bounds.width < bounds.height) ? bounds.width: bounds.height) / 2 : rad
        layer.masksToBounds = true
    }
}

