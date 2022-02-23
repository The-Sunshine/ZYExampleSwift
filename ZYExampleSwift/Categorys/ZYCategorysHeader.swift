//
//  ZYCategorysHeader.swift
//  ZYExampleSwift
//
//  Created by zy on 2022/1/8.
//

import Foundation
import UIKit

let zy_screen_width = UIScreen.main.bounds.width
let zy_screen_height = UIScreen.main.bounds.height

var isIphone: Bool {
    return UIDevice.current.userInterfaceIdiom == .phone
}

var isIphoneX: Bool {
    return UIDevice.current.userInterfaceIdiom == .phone &&
    max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) >= 812
}

//MARK: print
func ZYLog<T>(_ message: T, file: String = #file, function: String = #function, lineNumber: Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("(\(fileName) func:\(function) line:\(lineNumber))-\n\(message)")
    #endif
}

func zy_userDefaults_setValue(_ value: Any?, forKey key: String) {
    UserDefaults.standard.setValue(value, forKey: key)
    UserDefaults.standard.synchronize()
}

func zy_userDefaults_object(forKey defaultName: String) -> Any? {
    return UserDefaults.standard.object(forKey: defaultName) ?? ""
}

