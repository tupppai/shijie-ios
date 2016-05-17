//
//  PPSettingSecurityViewController.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/13.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPSettingSecurityViewController: UIViewController {
    
    private var tableView: UITableView!
    
    private let detailCellIdentifier = "DetailCellIdentifier"
    
    private let bindCellphoneCellIdentifier = "BindCellphoneCellIdentifier"
    
    private let bindThirdPartyCellIdentifier = "BindThirdPartyCellIdentifier"
    
    // MARK: UI life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UI setup
    private func setupSubviews(){
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(hex: 0xF7F7F7)
        tableView.separatorStyle = .None
        
        tableView.registerClass(PPDetailTableViewCell.self, forCellReuseIdentifier: detailCellIdentifier)
        tableView.registerClass(PPBindCellphoneTableViewCell.self, forCellReuseIdentifier: bindCellphoneCellIdentifier)
        tableView.registerClass(PPBindThirdPartyPlatformTableViewCell.self, forCellReuseIdentifier: bindThirdPartyCellIdentifier)
        self.view.addSubview(tableView)
    }
    
    private func setupConstraints(){
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
}


extension PPSettingSecurityViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }
        else{
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier(bindCellphoneCellIdentifier) as! PPBindCellphoneTableViewCell
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier(bindThirdPartyCellIdentifier) as! PPBindThirdPartyPlatformTableViewCell
                
                switch indexPath.row {
                case 1:
                    cell.iconImageView.image = UIImage(named: "icon_wechat_small")
                    cell.descLabel.text = "微信"
                case 2:
                    cell.iconImageView.image = UIImage(named: "icon_weibo_small")
                    cell.descLabel.text = "微博"
                case 3:
                    cell.iconImageView.image = UIImage(named: "icon_QQ_small")
                    cell.descLabel.text = "QQ"
                default:
                    cell.descLabel.text = "unknown"
                }
                return cell
            }
            
            
        }
        else{
            // indexPath.section == 1
            let cell = tableView.dequeueReusableCellWithIdentifier(detailCellIdentifier) as! PPDetailTableViewCell
            cell.mainTitleLabel.text = "登录密码"
            cell.subTitleLabel.text = "更改"
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            return nil
        }else{
            let separator = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: ScreenSize.SCREEN_HEIGHT, height: 10)))
            separator.backgroundColor = UIColor(hex:0xF7F7F7)
            return separator
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else{
            return 10
        }
    }
    
}