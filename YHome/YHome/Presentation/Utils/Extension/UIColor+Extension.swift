//
//  UIColor+Extension.swift
//  YHome
//
//  Created by kangho lee on 2023/02/26.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String) {
        let scan = Scanner(string: hex.trimmingCharacters(in: .newlines).replacingOccurrences(of: "#", with: ""))
        var color: UInt64 = 0
        scan.scanHexInt64(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
}
