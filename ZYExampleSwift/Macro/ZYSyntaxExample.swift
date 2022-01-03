//
//  ZYSyntaxExample.swift
//  ZYExampleSwift
//
//  Created by zy on 2022/1/3.
//

import Foundation

enum ZYExampleDemoType: String {
    case type1      = "1"
    case type2      = "2"
}

extension ZYExampleDemoType {
    var description: String {
        switch self {
        case .type1:        return "type1"
        case .type2:        return "type2"
        }
    }
}
