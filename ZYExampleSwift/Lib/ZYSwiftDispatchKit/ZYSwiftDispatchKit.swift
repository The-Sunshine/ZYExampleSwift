//
//  ZYSwiftDispatchKit.swift
//  ZYExampleSwift
//
//  Created by zy on 2021/12/31.
//

import UIKit

/// dispatch_once
/// 1.声明并添加代码块
/**
 static let zy_dispatch_once: Void = {
     <#code#><##>
 }()
 */
/// 2.调用，声明所在类.zy_dispatch_once
/**
 ClassName.zy_dispatch_once
 */

func zy_dispatch_after(after: CGFloat,
                       block: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + after) {
        block()
    }
}

func zy_dispatch_global_async(block: @escaping () -> Void) {
    DispatchQueue.global().async {
        block()
    }
}

func zy_dispatch_main_async(block: @escaping () -> Void) {
    DispatchQueue.main.async {
        block()
    }
}


