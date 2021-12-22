//
//  ZYTabBarController.swift
//  ZYExampleSwift
//
//  Created by kaka on 2021/12/14.
//

import UIKit

class ZYTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewController(vc: ZYBaseViewController(), imageName: "", title: "首页")
        addChildViewController(vc: ZYBaseViewController(), imageName: "", title: "首页")
        addChildViewController(vc: ZYBaseViewController(), imageName: "", title: "首页")
    }
    
    func addChildViewController(vc:UIViewController,imageName:String,title:String) {
        
        vc.title = title
        vc.tabBarItem = UITabBarItem(title: title,
                                     image: UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal),
                                     selectedImage: UIImage(named: imageName + "_selected")?.withRenderingMode(.alwaysOriginal))
        if UIDevice.current.userInterfaceIdiom == .phone {
            vc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        addChild(ZYNavigationController(rootViewController: vc))
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
