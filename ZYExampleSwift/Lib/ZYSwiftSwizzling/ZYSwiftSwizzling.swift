//
//  ZYSwiftSwizzling.swift
//  ZYExampleSwift
//
//  Created by zy on 2021/12/31.
//

import UIKit

/// 方法交换使用方式
/**
 extension <#className#>: ZYSwiftLoadFunctionProtocol {
     static func zy_load_function() {
         exchangeSwizzleMethod
     }
     
     private static let exchangeSwizzleMethod: Void = {
         /// 被交换的方法
         let originalSelector = #selector(viewWillAppear(_:))
         let swizzledSelector = #selector(swizzled_viewWillAppear(_:))
         ZYSwizzling.zy_swizzlingForClass(ViewController.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
     }()
     
     /// 需要交换的方法
     @objc func swizzled_viewWillAppear(_ animated: Bool) {
         swizzled_viewWillAppear(animated)
         print("swizzled_viewWillAppear")
     }
 }
*/
 
class ZYSwiftSwizzling: NSObject {
    
    /// 方法交换
    static func zy_swizzlingForClass(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(forClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
        guard (originalMethod != nil && swizzledMethod != nil) else {
            return
        }
        if class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!)) {
            class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
    
    /// 获取所有变量
    class func zy_ivars<T>(from type: T.Type) {
        var count: UInt32 = 0
        let ivars = class_copyIvarList(type as? AnyClass, &count)
        for index in 0..<count {
            guard let ivar = ivars?[Int(index)] else { continue }
            guard let namePointer = ivar_getName(ivar) else { continue }
            guard let name = String.init(utf8String: namePointer) else { continue }
            print("ivar_name: \(name)")
        }
    }
    
    /// 获取所有方法
    class func zy_methods<T>(from type: T.Type) {
        var count: UInt32 = 0
        let methods = class_copyMethodList(type as? AnyClass, &count)
        for index in 0..<count {
            guard let method = methods?[Int(index)] else { continue }
            let selector = method_getName(method)
            let name = NSStringFromSelector(selector)
            print("method_name: \(name)")
        }
    }
    
    /// 获取所有属性
    class func zy_properties<T>(from type: T.Type) {
        var count:UInt32 = 0
        let properties = class_copyPropertyList(type as? AnyClass, &count)
        for index in 0..<count {
            guard let property = properties?[Int(index)] else { continue }
            let propertyName = String(cString: property_getName(property))
            print("properties_name: \(propertyName)")
        }
        free(properties)
    }
    
    /// 获取所有协议
    class func zy_protocols<T>(from type: T.Type) {
        var protocolCount: UInt32 = 0
        let protocolList = class_copyProtocolList(type as? AnyClass, &protocolCount)
        for i in 0..<protocolCount {
            let protocolName = protocol_getName(protocolList![Int(i)])
            let protocolKey = String(cString: protocolName)
            debugPrint(protocolKey)
            
            var protocolMethodCount: UInt32 = 0
            //第一个bool类型：是否是require方法 第二个bool类型：是否是实例方法
            let protocolMethodList = protocol_copyMethodDescriptionList(protocolList![Int(i)], true, true, &protocolMethodCount)
            for j in 0..<protocolMethodCount {
                let method = protocolMethodList![Int(j)]
                debugPrint("protocol_name: \(String(describing: method.name))")
            }
        }
    }

}
