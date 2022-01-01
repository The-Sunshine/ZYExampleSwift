//
//  ZYBaseViewController.swift
//  ZYExampleSwift
//
//  Created by zy on 2021/12/15.
//

import UIKit

class ZYBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }

        initNaviBar()
        initUI()
    }
    
    private func initNaviBar() {
        // 一行代码搞定导航栏颜色
        navBarBarTintColor = .red
        // 一行代码搞定导航栏透明度
        navBarBackgroundAlpha = 1
        // 一行代码搞定导航栏两边按钮颜色
        navBarTintColor = UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1.0)
        // 一行代码搞定导航栏上标题颜色
        navBarTitleColor = .black
        // 一行代码搞定状态栏是 default 还是 lightContent
        statusBarStyle = .default
        // 一行代码搞定导航栏底部分割线是否隐藏
        navBarShadowImageHidden = true;
    }
    
    func initUI() {}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ZYBaseViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}
