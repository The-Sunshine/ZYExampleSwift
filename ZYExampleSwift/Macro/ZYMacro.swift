//
//  ZYMacro.swift
//  ZYExampleSwift
//
//  Created by zy on 2022/1/1.
//

import Foundation
import UIKit
import Kingfisher

extension UIColor {
    class var theme:UIColor {
        return UIColor.yellow
    }
}

extension String {
    static let zy_demo_key = "zy_demo_key"
}

extension NSNotification.Name {
    static let zy_noti = NSNotification.Name("zy_noti")
}

let zy_screen_width = UIScreen.main.bounds.width
let zy_screen_height = UIScreen.main.bounds.height

var isIphone: Bool {
    return UIDevice.current.userInterfaceIdiom == .phone
}

var isIphoneX: Bool {
    return UIDevice.current.userInterfaceIdiom == .phone &&
    (max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 812 ||
     max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 896)
}

//MARK: print
func ZYLog<T>(_ message: T, file: String = #file, function: String = #function, lineNumber: Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("(\(fileName) func:\(function) line:\(lineNumber))-\n\(message)")
    #endif
}


