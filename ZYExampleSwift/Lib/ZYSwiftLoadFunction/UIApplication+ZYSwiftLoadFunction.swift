//
//  UIApplication+ZYSwiftLoadFunction.swift
//  ZYSwiftLoadFunction
//
//  Created by zy on 2021/12/31.
//

import Foundation
import UIKit

/// 实现OC中load同样的效果
/// 1.在AppDelegate中重写next，非SceneDelegate
/**
 override open var next: UIResponder? {
     // Called before applicationDidFinishLaunching
     UIApplication.zy_appDelegate_load
     return super.next
 }
 */
/// 2.实现 ZYReceiveLoadProtocol 协议，调用 zy_receiveLoad 方法
/**
 extension ViewController: ZYSwiftLoadFunctionProtocol {
     static func zy_load_function() {
         <#code#>
     }
 }
 */


public protocol ZYSwiftLoadFunctionProtocol {
    static func zy_load_function()
}

class ZYSwiftLoadFunction {
    static func harmlessSendMessage() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            (types[index] as? ZYSwiftLoadFunctionProtocol.Type)?.zy_load_function()
        }
        types.deallocate()
    }
}

extension UIApplication {

    public static let zy_appDelegate_load: Void = {
        ZYSwiftLoadFunction.harmlessSendMessage()
    }()
}
