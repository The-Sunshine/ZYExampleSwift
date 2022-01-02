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
        case .develop:          return "开发环境"
        case .test:             return "测试环境"
        case .prepareRelease:   return "预发环境"
        case .release:          return "正式环境"
        }
    }
}

class ZYEnvironmentService: NSObject {

    //MARK: --------------------------------------------public
    
    /// 准备环境和url
    /// - Parameters:
    ///   - develop: 开发
    ///   - test: 测试
    ///   - prepareRelease: 预发
    ///   - release: 正式
    static public func prepareEnvironmentLocalURLString(develop: String?,
                                                       test: String?,
                                                       prepareRelease: String?,
                                                       release: String) {
#if DEBUG
        if test?.count ?? 0 > 0 {
            ZYEnvironmentService.shared.typeArray.append(.test)
            ZYEnvironmentService.shared.urlStringArray.append(test ?? "")
        }
        if develop?.count ?? 0 > 0 {
            ZYEnvironmentService.shared.typeArray.append(.develop)
            ZYEnvironmentService.shared.urlStringArray.append(develop ?? "")
        }
        if prepareRelease?.count ?? 0 > 0 {
            ZYEnvironmentService.shared.typeArray.append(.prepareRelease)
            ZYEnvironmentService.shared.urlStringArray.append(prepareRelease ?? "")
        }
        if release.count > 0 {
            ZYEnvironmentService.shared.typeArray.append(.release)
            ZYEnvironmentService.shared.urlStringArray.append(release)
        }
        assert(ZYEnvironmentService.shared.urlStringArray.count > 0, "prepareEnvironmentDevelopURLString未配置url")
        
        var type = ZYEnvironmentService.currentEnvironment()
        if !ZYEnvironmentService.shared.typeArray.contains(type) {
            type = ZYEnvironmentService.shared.typeArray.first ?? .develop
            let typeDesc = ZYEnvironmentService.shared.typeArray.first?.description
            setUserDefaults(value: typeDesc ?? "", key: ZYEnvironmentService.ZYEnvironmentServiceType_Key)
            setUserDefaults(value: ZYEnvironmentService.shared.urlStringArray.first ?? "", key: ZYEnvironmentService.ZYEnvironmentServiceURLString_Key)
        }
        
        let index: Int = ZYEnvironmentService.shared.typeArray.firstIndex {$0 == type} ?? 0
        let urlString = ZYEnvironmentService.shared.urlStringArray[index]
        setUserDefaults(value: urlString, key: ZYEnvironmentServiceURLString_Key)
        
        ZYEnvironmentService.shared.noteLabel.text = currentEnvironment().description
#else
        setUserDefaults(value: release, key: ZYEnvironmentServiceURLString_Key)
#endif
    }

    /// 读取当前环境
    /// - Returns: ZYEnvironmentServiceType
    static func currentEnvironment() -> ZYEnvironmentServiceType {
#if DEBUG
        let typeString = getUserDefaultsObject(key: ZYEnvironmentServiceType_Key)
        if typeString == nil {
            return .develop
        }

        for value in ZYEnvironmentService.shared.serviceTypeArray {
            if value.description == typeString as! String {
                return value
            }
        }
        
        return .develop
#else
        return .release;
#endif
    }
    
    /// 读取当前环境的url
    /// - Returns: String
    static func currentEnvironmentURLString() -> String {
        return getUserDefaultsObject(key: ZYEnvironmentServiceURLString_Key) as! String
    }
    
    /// 添加环境切换双击手势 仅在DEBUG环境打开
    /// - Parameters:
    ///   - tapView: 可点击控件
    ///   - changeEnvironmentBlock: 切换成功后配置
    ///   - changeAfterExit: 切换0.5秒后是否退出程序
    @objc static public func addEnvironmentTapView(tapView: UIView,
                                            changeEnvironmentBlock: @escaping () -> Void,
                                            changeAfterExit: Bool) {
#if DEBUG
        ZYEnvironmentService.shared.addTapView(tapView: tapView,
                                               changeEnvironmentBlock: changeEnvironmentBlock,
                                               changeAfterExit: changeAfterExit)
#endif
    }
    
    /// 添加其他服务配置显示 自定义显示配置 不可点击
    /// - Parameter String
    @objc static public func addOtherServiceDisplayStringArray(array: Array<String>) {
#if DEBUG
        ZYEnvironmentService.shared.otherServiceArray = array
#endif
    }

    //MARK: --------------------------------------------private
    @objc private static let shared = ZYEnvironmentService()
    private var typeArray = Array<ZYEnvironmentServiceType>()
    private var urlStringArray = Array<String>()
    private var otherServiceArray = Array<String>()

    private static let ZYEnvironmentServiceURLString_Key = "ZYEnvironmentServiceURLString_Key"
    private static let ZYEnvironmentServiceType_Key = "ZYEnvironmentServiceType_Key"
    
    private var _changeAfterExit: Bool = false
    private var _changeEnvironmentBlock: (() -> Void) = {}
    private let serviceTypeArray : Array<ZYEnvironmentServiceType> = [.develop,
                                                                      .test,
                                                                      .prepareRelease,
                                                                      .release]

    private func addTapView(tapView: UIView,
                            changeEnvironmentBlock: @escaping () -> Void,
                            changeAfterExit: Bool) {
        _changeEnvironmentBlock = changeEnvironmentBlock
        _changeAfterExit = changeAfterExit
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showEnvionmentAlert))
        tap.numberOfTapsRequired = 2;
        tapView.isUserInteractionEnabled = true
        tapView.addGestureRecognizer(tap)
    }

    @objc private func showEnvionmentAlert() {
        
        let currentType = ZYEnvironmentService.currentEnvironment()
        let url = ZYEnvironmentService.currentEnvironmentURLString()
        let currentEnvironmentString = "当前环境:" + currentType.description + "-" + url
        let alertController = UIAlertController(title: currentEnvironmentString, message: nil, preferredStyle: .actionSheet)
        
        for (index,type) in typeArray.enumerated() {
            if type != currentType {
                let title = type.description +  "-" + urlStringArray[index]
                let action = UIAlertAction(title: title, style: .destructive) { action in
                    let prefix = action.title?.prefix(4) ?? ""
                    self.makeSureChangeEnvionmentAlert(prefixString: String(prefix))
                }
                alertController.addAction(action)
            }
        }
        
        for other in otherServiceArray {
            if other.count > 0 {
                let action = UIAlertAction(title: other, style: .default, handler: nil)
                alertController.addAction(action)
                action.isEnabled = false
            }
        }
        
        let action = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(action)
        currentViewController?.present(alertController, animated: true, completion: nil)
    }
    
    private func makeSureChangeEnvionmentAlert(prefixString:String) {
        var type : ZYEnvironmentServiceType = .develop
        
        for (index,value) in typeArray.enumerated() {
            if prefixString == value.description {
                type = typeArray[index]
            }
        }
        
        let alertController = UIAlertController(title: "切换环境", message: "是否切换环境到" + type.description, preferredStyle: .alert)
        let sureAction = UIAlertAction(title: "确定", style: .destructive) { action in
            
            ZYEnvironmentService.setUserDefaults(value: type.description, key: ZYEnvironmentService.ZYEnvironmentServiceType_Key)
            self.noteLabel.text = type.description;

            for (index,value) in self.typeArray.enumerated() {
                if value == type {
                    ZYEnvironmentService.setUserDefaults(value: self.urlStringArray[index], key: ZYEnvironmentService.ZYEnvironmentServiceURLString_Key)
                }
            }
                
            self._changeEnvironmentBlock()
            
            if self._changeAfterExit {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    exit(0);
                }
            }
        }
        alertController.addAction(sureAction)

        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        currentViewController?.present(alertController, animated: true, completion: nil)
    }
    
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
       
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            let window = self.currentWindow
            if window != nil {
                window?.addSubview(label)
            }
        }
        
        return label
    }()
    
    //MARK: ---------------------------------------------tool
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

    static private func setUserDefaults(value:Any ,key:String) {
        UserDefaults.standard.setValue(value, forKey: key)
        UserDefaults.standard.synchronize()
    }

    static private func getUserDefaultsObject(key:String) -> Any? {
        return UserDefaults.standard.object(forKey: key) ?? ""
    }
}

