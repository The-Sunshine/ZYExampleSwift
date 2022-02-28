//
//  UIButton+ZYExtension.swift
//  ZYExampleSwift
//
//  Created by zyq on 2022/2/21.
//

import Foundation
import UIKit

enum ZYButtonImagePosition : Int{
 
    case top = 0
    case left
    case bottom
    case right
}

extension UIButton {

    /// setImageAndTitle
    /// - Parameters:
    ///   - imageName: 图片的名字
    ///   - title: title
    ///   - type: image 的位置
    ///   - space: 图片文字之间的间距
    func setImageWithTitle(imageName:String,title:String,type:ZYButtonImagePosition,Space space:CGFloat)  {
      
        self.setTitle(title, for: .normal)
        self.setImage(UIImage(named:imageName), for: .normal)
        
        let imageWith :CGFloat = (self.imageView?.frame.size.width)!;
        let imageHeight :CGFloat = (self.imageView?.frame.size.height)!;
      
        var labelWidth :CGFloat = 0.0;
        var labelHeight :CGFloat = 0.0;

        labelWidth = CGFloat(self.titleLabel!.intrinsicContentSize.width);
        labelHeight = CGFloat(self.titleLabel!.intrinsicContentSize.height);
        var  imageEdgeInsets :UIEdgeInsets = UIEdgeInsets();
        var  labelEdgeInsets :UIEdgeInsets = UIEdgeInsets();
       
        switch type {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight - space / 2.0, left: 0, bottom: 0, right: -labelWidth);
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -space * 2, bottom: -imageHeight - space / 2.0, right: 0);
            break;
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space / 2.0, bottom: 0, right: space / 2.0);
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space / 2.0, bottom: 0, right: -space / 2.0);
            break;
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight-space / 2.0, right: -labelWidth);
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight - space / 2.0, left:-space * 2, bottom: 0, right: 0);
            break;
        case .right:
            labelWidth += 10
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + space / 2.0, bottom: 0, right: -labelWidth - space / 2.0);
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWith - space / 2.0, bottom: 0, right: imageWith+space / 2.0);
            break;
        }
        
        self.titleEdgeInsets = labelEdgeInsets;
        self.imageEdgeInsets = imageEdgeInsets;
    }
}
