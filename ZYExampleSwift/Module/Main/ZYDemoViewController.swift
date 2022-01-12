//
//  ZYDemoViewController.swift
//  ZYExampleSwift
//
//  Created by zy on 2021/12/15.
//

import UIKit
import SCLAlertView

class ZYDemoViewController: ZYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = UIImageView()
        view.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        self.view.addSubview(view)
        view.image = UIImage.fillColor(color: UIColor.red)
        
        ZYEnvironmentService.addEnvironmentTapView(tapView: view, changeEnvironmentBlock: {
            print("修改了")
        }, changeAfterExit: false)
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
