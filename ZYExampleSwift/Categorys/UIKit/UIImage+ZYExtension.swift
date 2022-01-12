//
//  UIImage+ZYExtension.swift
//  ZYExampleSwift
//
//  Created by zy on 2022/1/8.
//

import Foundation
import UIKit

extension UIImage {
    static func fillColor(color:UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
