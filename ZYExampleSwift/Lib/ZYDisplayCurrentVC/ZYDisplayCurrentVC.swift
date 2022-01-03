//
//  ZYDisplayCurrentVC.swift
//  ZYExampleSwift
//
//  Created by zy on 2021/12/31.
//
#if DEBUG

import UIKit
import SwiftUI

/// 使用方式
/// 1.在AppDelegate中重写next，非SceneDelegate
/**
 override open var next: UIResponder? {
     // Called before applicationDidFinishLaunching
     UIApplication.zy_appDelegate_load
     return super.next
 }
 */
/// 2.实现自定义前缀
/**
 #if DEBUG
 ZYDisplayCurrentVC.shared.note = "<#code#>"
 #endif
 */
/// 2.实现自定义显示框位置 宽度内部已经自适应，
/**
 #if DEBUG
 ZYDisplayCurrentVC.shared.noteLabel.frame = CGRect(x: 0, y: 100, width: 0, height: 20)
 #endif
 */


class ZYDisplayCurrentVC: NSObject {

    @objc public static let shared = ZYDisplayCurrentVC()
    
    public var whiteListVCArray = Array<String>()
    public var whiteListPrefixVCArray =  Array<String>()
    
    public var note = String()
    
    public lazy var noteLabel: UILabel = {
        let size = CGSize(width: 0, height: 20);
        var origin = CGPoint()
        if UIScreen.main.bounds.size.height >= 812 {
            origin = CGPoint(x: 62, y:32)
        } else {
            origin = CGPoint(x: 62, y:16)
        }
        
        let label = UILabel()
        label.frame = CGRect(origin: origin, size: size)
        label.textColor = UIColor(red: 53.0 / 255, green: 205.0 / 255, blue: 73.0 / 255, alpha: 1.0)
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 14)
        label.backgroundColor = UIColor(white: 0, alpha: 0.5)
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true;
        addLabel(label: label)
        
        return label
    }()
    
    private func addLabel(label: UILabel) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            let window = self.currentWindow
            if window != nil {
                window?.addSubview(label)
            } else {
                self.addLabel(label: label)
            }
        }
    }
    
    private var currentWindow: UIWindow? {
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


#endif
