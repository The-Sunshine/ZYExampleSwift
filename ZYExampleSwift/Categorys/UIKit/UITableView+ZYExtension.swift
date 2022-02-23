//
//  UITableView+ZYExtension.swift
//  ZYExampleSwift
//
//  Created by zyq on 2022/2/24.
//

import Foundation
import UIKit

extension UITableView {
    
    static func newTableViewGroupedWithTarget(target:Any) ->UITableView {
        
        let tableView = UITableView(frame: CGRect(), style: .grouped)
        tableView.delegate = target as? UITableViewDelegate;
        tableView.dataSource = target as? UITableViewDataSource
        tableView.separatorStyle = .none;
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 0.01)
        tableView.tableHeaderView = UIView(frame: frame)
        tableView.tableFooterView = UIView(frame: frame)
        return tableView
    }
    
    func removeCellLine() {
        self.separatorStyle = .none
    }
    
}
