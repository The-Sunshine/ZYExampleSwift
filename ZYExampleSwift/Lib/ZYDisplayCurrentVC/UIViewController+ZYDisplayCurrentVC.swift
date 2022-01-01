//
//  UIViewController+ZYDisplayCurrentVC.swift
//  ZYExampleSwift
//
//  Created by zy on 2021/12/31.
//

#if DEBUG

import Foundation
import UIKit

extension UIViewController: ZYSwiftLoadFunctionProtocol {
    public static func zy_load_function() {
        exchangeSwizzleMethod
    }
    
    private static let exchangeSwizzleMethod: Void = {
        /// 被交换的方法
        let originalSelector = #selector(viewWillAppear(_:))
        let swizzledSelector = #selector(swizzled_viewWillAppear(_:))
        ZYSwiftSwizzling.zy_swizzlingForClass(UIViewController.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
    
    /// 需要交换的方法
    @objc func swizzled_viewWillAppear(_ animated: Bool) {
        
        if !isPrivateVC() {
            let label = ZYDisplayCurrentVC.shared.noteLabel
            if (label.superview != nil) {
                label.superview?.bringSubviewToFront(label)
            }
            
            guard let objc_class = object_getClass(self) else { return }
            guard let class_name = NSStringFromClass(objc_class).components(separatedBy: ".").last else {
                return
            }
            
            label.text = ZYDisplayCurrentVC.shared.note + class_name
            label.sizeToFit()
        }
        
        swizzled_viewWillAppear(animated)
    }
    
    private func isPrivateVC() -> Bool {
     
        let classString = NSStringFromClass(UIViewController.self)
        return (classString == "UIAlertController" ||
                classString == "_UIAlertControllerTextFieldViewController" ||
                classString == "UIApplicationRotationFollowingController" ||
                classString == "UIInputWindowController")
    }
}

#endif
