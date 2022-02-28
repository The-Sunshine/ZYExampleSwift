//
//  ZYUIExample.swift
//  ZYExampleSwift
//
//  Created by zyq on 2022/2/23.
//

import Foundation

/// UIView
/**
 let balanceView = UIView()
 balanceView.backgroundColor  = <#color#>
 balanceView.layer.cornerRadius =  <#radius#>;
 balanceView.layer.masksToBounds = true
 <#view#>.addSubview(balanceView)
 balanceView.snp.makeConstraints { make in
     make.left.equalTo(0)
     make.right.equalTo(0)
     make.top.equalTo(0)
     make.bottom.equalTo(0)
 }
 
 */

/// UIImageView
/**
 let bgIV = UIImageView()
 <#view#>.addSubview(bgIV)
 bgIV.image = UIImage(named: "<#name#>")
 balanceView.snp.makeConstraints { make in
     make.left.equalTo(0)
     make.right.equalTo(0)
     make.top.equalTo(0)
     make.bottom.equalTo(0)
 }

 */

/// UILabel
/**
 let titleLabel = UILabel()
 titleLabel.text = "<#text#>"
 <#view#>.addSubview(titleLabel)
 titleLabel.textColor = <#color#>
 titleLabel.textAlignment = .center
 titleLabel.font = UIFont.systemFont(ofSize: <#size#>)
 titleLabel.snp.makeConstraints { make in
 make.left.equalTo(0)
 make.right.equalTo(0)
 make.top.equalTo(0)
 make.bottom.equalTo(0)
 }

 */

/// UIButton
/**
 let detailButton = UIButton()
 detailButton .setTitle("<#title#>", for: .normal)
 detailButton.titleLabel?.font = UIFont.systemFont(ofSize: <#size#>)
 detailButton.setImage(UIImage.init(named: "<#name#>"), for: .normal)
 detailButton .setTitleColor(<#color#>, for: .normal)
 detailButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 30+3/2.0, bottom: 0, right: -30-3/2.0);
 detailButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -5-3/2.0, bottom: 0, right: 5+3/2.0);
 detailButton .addTarget(self, action: #selector(<#sel#>), for: .touchUpInside)
 <#view#>.addSubview(detailButton)
 detailButton.snp.makeConstraints { make in
 make.left.equalTo(0)
 make.right.equalTo(0)
 make.top.equalTo(0)
 make.bottom.equalTo(0)
 }
 
 @objc func <#sel#>() {
    
 }
 
 detailButton.addTarget(self, action:#selector(<#sel#>(_:)), for:.touchUpInside)

 @objc func <#sel#>(_ button:UIButton) {
 }
 */

/// UITableView
/**
 let tableView = UITableView(frame: CGRect(), style: .grouped)
 tableView.delegate = self;
 tableView.dataSource = self
 tableView.backgroundColor = <#color#>
 <#view#>.addSubview(tableView)
 tableView.register(<#cellClass#>.classForCoder(), forCellReuseIdentifier: "<#id#>")
 tableView.snp.makeConstraints { make in
 make.left.equalTo(0)
 make.right.equalTo(0)
 make.top.equalTo(0)
 make.bottom.equalTo(0)
 }
 tableView.separatorColor = <#color#>

 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell :<#cellClass#> = tableView.dequeueReusableCell(withIdentifier: "<#id#>", for: indexPath) as! <#cellClass#>
     cell.backgroundColor = <#color#>
     
     let model = <#dataSource#>
     cell.setModel(model: model)
     
     return cell
 }
 
 func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
     return UIView(frame: CGRect(x: 0, y: 0, width: zy_screen_width, height: 0.01))
 }
 func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
     return 0.01
 }
 
 */

///lazy
/**
 lazy var view: UIView = {
    let view = UIView()
     return view
 }()
 
 */

