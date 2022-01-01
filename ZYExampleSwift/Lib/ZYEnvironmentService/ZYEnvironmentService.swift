//
//  ZYEnvironmentService.swift
//  ZYExampleSwift
//
//  Created by zy on 2021/12/31.
//

import UIKit

public enum ZYEnvironmentServiceType {
    case develop
    case test
    case prepareRelease
    case release
}

extension ZYEnvironmentServiceType {
    var description: String {
        switch self {
        case .develop: return "开发环境"
        case .test: return "测试环境"
        case .prepareRelease: return "预发环境"
        case .release: return "正式环境"
        }
    }
}

class ZYEnvironmentService: NSObject {

    //MARK: public
    
    /// 准备环境和url
    /// - Parameters:
    ///   - develop: 开发
    ///   - test: 测试
    ///   - prepareRelease: 预发
    ///   - release: 正式
    @objc public func prepareEnvironmentLocalURLString(develop: String,
                                                       test: String,
                                                       prepareRelease: String,
                                                       release: String) {
        
    }
    
    
    /// 读取当前环境
    /// - Returns: ZYEnvironmentServiceType
    public func currentEnvironment() -> ZYEnvironmentServiceType {
#if DEBUG
        return .develop;
#else
        return .release;
#endif
    }
    
    
    /// 读取当前环境的url
    /// - Returns: String
    public func currentEnvironmentURLString() -> String {
        
        return "";
    }
    
    
    /// 添加环境切换双击手势 仅在DEBUG环境打开
    /// - Parameters:
    ///   - tapView: 可点击控件
    ///   - changeEnvironmentBlock: 切换成功后配置
    ///   - changeAfterExit: 切换0.5秒后是否退出程序
    @objc public func addEnvironmentTapView(tapView: UIView,
                                            changeEnvironmentBlock: @escaping () -> Void,
                                            changeAfterExit: Bool) {
    

        
        changeEnvironmentBlock()
        
        if changeAfterExit {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                exit(0);
            }
        }
    }
    
    
    /// 添加其他服务配置显示 自定义显示配置 不可点击
    /// - Parameter String
    @objc public func addOtherServiceDisplayStringArray(array: Array<String>) {
        
        
    }

    //MARK: private
    @objc private static let shared = ZYEnvironmentService()

    
    
    
    private lazy var noteLabel: UILabel = {
        let size = CGSize(width: 60, height: 20);
        var origin = CGPoint()
        if UIScreen.main.bounds.size.height >= 812 {
            origin = CGPoint(x: UIScreen.main.bounds.size.width - size.width - 5, y:32)
        } else {
            origin = CGPoint(x: UIScreen.main.bounds.size.width - size.width - 5, y:16)
        }
        
        let label = UILabel()
        label.frame = CGRect(origin: origin, size: size)
        label.textColor = UIColor(red: 53.0 / 255, green: 205.0 / 255, blue: 73.0 / 255, alpha: 1.0)
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 14)
        label.backgroundColor = UIColor(white: 0, alpha: 0.5)
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true;
        
        let window = currentWindow
        if window != nil {
            window?.addSubview(label)
        }
        
        return label
    }()
    
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
    
    private var currentViewController: UIViewController? {
        return getCurrentViewControllerFrom(rootVC: currentWindow?.rootViewController)
    }
    
    private func getCurrentViewControllerFrom(rootVC: UIViewController?) -> UIViewController? {
        
        if let nav = rootVC as? UINavigationController {
            return getCurrentViewControllerFrom(rootVC: nav.visibleViewController)
        }
        if let tab = rootVC as? UITabBarController {
            return getCurrentViewControllerFrom(rootVC: tab.selectedViewController)
        }
        if let presented = rootVC?.presentedViewController {
            return getCurrentViewControllerFrom(rootVC: presented)
        }
        if let split = rootVC as? UISplitViewController{
            return getCurrentViewControllerFrom(rootVC: split.presentingViewController)
        }
        return rootVC
    }

}

