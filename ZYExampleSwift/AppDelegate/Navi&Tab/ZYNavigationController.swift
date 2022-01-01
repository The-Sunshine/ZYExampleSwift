//
//  ZYNavigationController.swift
//  ZYExampleSwift
//
//  Created by zy on 2021/12/15.
//

import UIKit


class ZYNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            if viewControllers.count > 1 {
                navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navi_back"),
                                                                   style: .done,
                                                                   target: self,
                                                                   action: #selector(backClick))
            }
        }
        super.pushViewController(viewController, animated: animated)
    }

    @objc func backClick() {
        navigationController?.popViewController(animated: true)
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
