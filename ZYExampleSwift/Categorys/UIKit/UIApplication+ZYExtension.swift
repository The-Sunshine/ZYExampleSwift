//
//  UIApplication+ZYExtension.swift
//  ZYExampleSwift
//
//  Created by zy on 2021/12/31.
//

import Foundation
import UIKit

extension UIApplication {
    
    // MARK: - 获取当前屏幕显示的Window
    var currentWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            let windowScene = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
            if let window = windowScene
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first{
                return window
            }else if let window = UIApplication.shared.delegate?.window{
                return window
            }else{
                return nil
            }
        } else {
            if let window = UIApplication.shared.delegate?.window{
                return window
            }else{
                return nil
            }
        }
    }
    
}
