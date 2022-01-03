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
        
        if !isPrivateVC(className: NSStringFromClass(UIViewController.self)) {
            let label = ZYDisplayCurrentVC.shared.noteLabel
            if (label.superview != nil) {
                label.superview?.bringSubviewToFront(label)
            }

            let class_name = NSStringFromClass(type(of: self)).components(separatedBy: ".").last ?? ""
            if isPrivateVC(className: class_name) {
                return
            }

            label.text = ZYDisplayCurrentVC.shared.note + class_name
            label.sizeToFit()
        }
        
        swizzled_viewWillAppear(animated)
    }
    
    private func isPrivateVC(className: String) -> Bool {
        
        for value in ZYDisplayCurrentVC.shared.whiteListPrefixVCArray {
            if value.count == 0 {
                break
            }
            if className.hasPrefix(value) {
                return true
            }
        }
        
        for value in ZYDisplayCurrentVC.shared.whiteListVCArray {
            if value.count == 0 {
                break
            }
            if className == value {
                return true
            }
        }

        return (className == "UIAlertController" ||
                className == "_UIAlertControllerTextFieldViewController" ||
                className == "UIApplicationRotationFollowingController" ||
                className == "UIInputWindowController")
    }
}

#endif
