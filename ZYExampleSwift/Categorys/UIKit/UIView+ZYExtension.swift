//
//  UIView+ZYExtension.swift
//  ZYExampleSwift
//
//  Created by zy on 2022/1/8.
//

import Foundation
import UIKit

extension UIView {

    func layerCornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func layerRoundedCorners() {
        layerCornerRadius(bounds.size.width / 2)
    }
    
    func layerborder(_ width: CGFloat,color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }

    
}
