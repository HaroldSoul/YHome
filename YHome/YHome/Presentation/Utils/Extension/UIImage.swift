//
//  UIImage.swift
//  YHome
//
//  Created by kangho lee on 2023/02/26.
//

import Foundation
import UIKit

extension UIImage {
    func withColor(_ color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let drawRect = CGRect(x: 0,y: 0,width: size.width,height: size.height)
        color.setFill()
        UIRectFill(drawRect)
        draw(in: drawRect, blendMode: .destinationIn, alpha: 1)

        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
}
