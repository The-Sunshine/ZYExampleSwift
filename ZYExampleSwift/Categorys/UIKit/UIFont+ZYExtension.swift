//
//  UIFont+ZYExtension.swift
//  ZYExampleSwift
//
//  Created by zy on 2022/1/8.
//

import Foundation
import UIKit

extension UIFont {

    static func allSystemFontsNames() {
        
        for fontfamilyname in UIFont.familyNames {
            print("-------------")
            print("family:'\(fontfamilyname)'")
            for fontName in UIFont.fontNames(forFamilyName: fontfamilyname) {
                print("\tfont:'\(fontName)'")
            }
        }
    }
}
