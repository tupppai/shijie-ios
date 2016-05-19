//
//  PPMeTableViewController.swift
//  vision_demo
//
//  Created by TUPAI-Huangwei on 3/17/16.
//  Copyright © 2016 TUPAI-Huangwei. All rights reserved.
//

import UIKit


private struct PPMeTableViewConstants
{
    static let cellIdentifier   = "SettingTableViewCell"
}

class PPMeTableViewController: UITableViewController {
    
    // MARK: - UI life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "单聊", style: UIBarButtonItemStyle.Plain, target: self, action: "privateChat")
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.backgroundColor = UIColor(hex: 0xF7F7F7)
    }
    
    func privateChat() {
        //打开会话界面
        let chatWithSelf = RCConversationViewController(conversationType: RCConversationType.ConversationType_PRIVATE, targetId: "me")
        chatWithSelf.hidesBottomBarWhenPushed = true
        chatWithSelf.title = "想显示的会话标题"
        self.navigationController?.pushViewController(chatWithSelf, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UI components setup
    private func setupSubViews(){
        self.tableView.registerNib(UINib(nibName: PPMeTableViewConstants.cellIdentifier,
            bundle: nil),
            forCellReuseIdentifier: PPMeTableViewConstants.cellIdentifier)
        self.tableView.sectionHeaderHeight = 5.0
        self.tableView.sectionFooterHeight = 5.0
        self.tableView.separatorStyle      = .None
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 3
        }
        else if section == 1{
            return 3
        }
        else{
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =
        tableView.dequeueReusableCellWithIdentifier(PPMeTableViewConstants.cellIdentifier, forIndexPath: indexPath) as! SettingTableViewCell
        
        if indexPath.section == 0{
            switch indexPath.row{
            case 0:
                cell.settingTextLabel.text = "我的收益(微信提现)"
                cell.numberCountLabel.text = "0"
                cell.settingIndicatorImageView.image = UIImage(named: "ic_credit")
            case 1:
                cell.settingTextLabel.text = "我的等级"
                cell.numberCountLabel.text = "2"
                cell.settingIndicatorImageView.image = UIImage(named: "ic_star")
            case 2:
                cell.settingTextLabel.text = "我的see币"
                cell.numberCountLabel.text = "50"
                cell.settingIndicatorImageView.image = UIImage(named: "ic_diamond")
            default:
                break
            }
        }else{
            // indexPath.section == 1
            switch indexPath.row{
            case 0:
                cell.settingTextLabel.text = "设置"
                cell.numberCountLabel.text = ""
                cell.settingIndicatorImageView.image = UIImage(named: "ic_setting")
            case 1:
                cell.settingTextLabel.text = "大V认证"
                cell.numberCountLabel.text = "已认证"
                cell.settingIndicatorImageView.image = UIImage(named: "ic_certificate")
            case 2:
                cell.settingTextLabel.text = "退出登录"
                cell.numberCountLabel.text = ""
                cell.settingIndicatorImageView.image = UIImage(named: "ic_logout")
            default:
                break
            }
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.section == 1 && indexPath.row == 0{
            self.navigationController?.pushViewController(PPSettingViewController(), animated: true)
        }
        else if (indexPath.section == 1 && indexPath.row == 1){
            let vipVC = PPVIPVerificationViewController()
            vipVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vipVC, animated: true)
        }
        else{
            self.navigationController?.pushViewController(PPFriendViewController(), animated: true)
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
//            let header = UserHeaderView()
//            let header = UserHeaderView2()
            let header = PPMeUserHeaderView()
            return header
        }
        else{
            return UIView(frame: CGRectZero)
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
//            return 310
//            return 235
            return 298
        }else{
            return 0
        }
    }
    
    
}
