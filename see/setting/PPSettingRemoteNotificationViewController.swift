//
//  PPSettingRemoteNotificationViewController.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/13.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPSettingRemoteNotificationViewController: UIViewController {

    private var tableView: UITableView!
    
    private let notificationSwitchCellIdentifier = "notificationSwitchCellIdentifier"
    
    private let notificationBanUserSwitchCellIdentifier = "notificationBanUserSwitchCellIdentifier"
    
    
    // MARK: UI life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "推送通知"
        setupSubviews()
        setupConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UI setup
    private func setupSubviews(){
        tableView                = UITableView(frame: CGRectZero, style: .Plain)
        tableView.delegate       = self
        tableView.dataSource     = self
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor(hex: 0xF7F7F7)
        tableView.registerClass(PPNotificationSwitchTableViewCell.self, forCellReuseIdentifier: notificationSwitchCellIdentifier)
        tableView.registerClass(PPNotificationSwitchTableViewCell_banUser.self, forCellReuseIdentifier: notificationBanUserSwitchCellIdentifier)
        self.view.addSubview(tableView)
        
    }
    
    private func setupConstraints(){
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
}

extension PPSettingRemoteNotificationViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(notificationSwitchCellIdentifier) as! PPNotificationSwitchTableViewCell
            return cell
            
        }else{
            // indexPath.section == 1
            let cell = tableView.dequeueReusableCellWithIdentifier(notificationBanUserSwitchCellIdentifier) as! PPNotificationSwitchTableViewCell_banUser
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }else{
            // section == 1
            let promptLabel = UILabel()
            promptLabel.text = "   关闭某个人的消息提醒，不再收到TA的提示"
            promptLabel.textColor = UIColor(hex: 0x000000, alpha: 0.4)
            promptLabel.font = UIFont.systemFontOfSize(12)
            return promptLabel
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }else{
            return 40
        }
    }
}
