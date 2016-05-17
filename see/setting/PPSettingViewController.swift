//
//  PPSettingViewController.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/13.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPSettingViewController: UIViewController {
    private var tableView: UITableView!
    
    private let indexSettingArray =
        ["黑名单", "编辑个人资料","账号安全和管理","推送管理","用户反馈", "关于see"]
    private let cellIdentifierStr = "SettingCell"
    
    // MARK: UI life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        setupSubviews()
        setupConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK : UI setup
    private func setupSubviews(){
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier:cellIdentifierStr)
        self.view.addSubview(tableView)
    }
    
    private func setupConstraints(){
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    private func setupNavBar(){
        
    }
    
}

extension PPSettingViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifierStr)
        cell?.accessoryType = .DisclosureIndicator
        cell?.textLabel!.text = indexSettingArray[indexPath.row]
        cell?.textLabel!.font = UIFont.systemFontOfSize(14)
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(PPSettingBlackListViewController(), animated: true)
        case 1:
            self.navigationController?.pushViewController(PPSettingEditUserInfoViewController(), animated: true)
        case 2:
            self.navigationController?.pushViewController(PPSettingSecurityViewController(), animated: true)
        case 3:
            self.navigationController?.pushViewController(PPSettingRemoteNotificationViewController(), animated: true)
        case 4:
            self.navigationController?.pushViewController(PPSettingComplainViewController(), animated: true)
        case 5:
            self.navigationController?.pushViewController(PPSettingAboutAPPViewController(), animated: true)
        default:
            break
        }
    }
}
