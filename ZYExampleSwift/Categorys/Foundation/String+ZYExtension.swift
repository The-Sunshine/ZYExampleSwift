//
//  String+ZYExtension.swift
//  ZYExampleSwift
//
//  Created by zy on 2022/1/8.
//

import Foundation

extension String {
    func zy_isEmptyString () -> Bool {
        return self.count == 0
    }
    
    func zy_isReplaceSpaceEmptyString() -> Bool {
        return self.replacingOccurrences(of: " ", with: "").count == 0
    }
}
