//
//  PPSettingEditUserInfoViewController.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/13.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPSettingEditUserInfoViewController: UIViewController {

    private var tableView: UITableView!
    
    private let detailCellIdentifier = "DetailCellIdentifier"
    
    private let detailDisclosureCellIdentifier = "detailDisclosureCellIdentifier"
    
    private let editAvatarCellIdentifier = "EditAvatarCellIdentifier"

    private let indexTitleArray = ["昵称", "性别", "城市", "简介", "大V认证"]
    
    private let indexDetailedTitleArray = ["remy", "女", "深圳", "", "已认证"]
    
    // MARK:  UI life cycles
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
        tableView            = UITableView(frame: CGRectZero, style: .Plain)
        tableView.registerClass(PPDetailTableViewCell.self, forCellReuseIdentifier: detailCellIdentifier)
        tableView.registerClass(PPDetailDisclosureTableViewCell.self, forCellReuseIdentifier: detailDisclosureCellIdentifier)
        tableView.registerClass(PPEditAvatarCell.self, forCellReuseIdentifier: editAvatarCellIdentifier)
        tableView.delegate   = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    
    private func setupConstraints(){
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
}

extension PPSettingEditUserInfoViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            // first cell, editAvatarCell
            let cell = tableView.dequeueReusableCellWithIdentifier(editAvatarCellIdentifier) as! PPEditAvatarCell
            return cell
        }
        else{
            if indexPath.row == 5 {
                let cell = tableView.dequeueReusableCellWithIdentifier(detailCellIdentifier) as! PPDetailTableViewCell
                cell.mainTitleLabel.text = indexTitleArray[indexPath.row - 1]
                cell.subTitleLabel.text = indexDetailedTitleArray[indexPath.row - 1]
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier(detailDisclosureCellIdentifier) as! PPDetailDisclosureTableViewCell
                cell.mainTitleLabel.text = indexTitleArray[indexPath.row - 1]
                cell.subTitleLabel.text = indexDetailedTitleArray[indexPath.row - 1]
                return cell
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
}
