//
//  UITableViewCell+ZYExtension.swift
//  ZYExampleSwift
//
//  Created by zyq on 2022/2/24.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    static func newWithTableView(tableView:UITableView,
                                 identifier:String,
                                 style:UITableViewCell.CellStyle) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: style, reuseIdentifier: identifier)
        }
        return cell ?? UITableViewCell()
    }
}
