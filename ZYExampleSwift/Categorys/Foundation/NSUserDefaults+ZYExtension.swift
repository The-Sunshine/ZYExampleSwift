//
//  NSUserDefaults+ZYExtension.swift
//  ZYExampleSwift
//
//  Created by zy on 2022/1/3.
//

import Foundation

extension UserDefaults {
    
    static func zy_setValue(_ value: Any?, forKey key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
        UserDefaults.standard.synchronize()
    }

    static func zy_object(forKey defaultName: String) -> Any? {
        return UserDefaults.standard.object(forKey: defaultName) ?? ""
    }
}
