//
//  PPCoinsContributionListViewController.swift
//  live
//
//  Created by TUPAI-Huangwei on 3/23/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

private struct Constants{
    static let cellIdentifier = "PPPodiumUserTableViewCell"
}

class PPCoinsContributionViewController: UIViewController {
    
    // MARK: - UI life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: 0xF96520)
        setNeedsStatusBarAppearanceUpdate()
        edgesForExtendedLayout = .None
        
        setupSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.lt_reset()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // MARK: - UI components setup
    private func setupSubviews(){
        // overall coins collected label
        let overallCoinsCollectedLabel       = UILabel()
        overallCoinsCollectedLabel.text      = "232131 视券"
        overallCoinsCollectedLabel.textColor = UIColor.whiteColor()
        overallCoinsCollectedLabel.font      = UIFont.systemFontOfSize(20)
        view.addSubview(overallCoinsCollectedLabel)
        overallCoinsCollectedLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp_top)
            make.centerX.equalTo(view.snp_centerX)
        }
        
        // podium view
        let podiumView = PPPodiumView()
        view.addSubview(podiumView)
        podiumView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(overallCoinsCollectedLabel.snp_bottom).offset(20)
            make.left.equalTo(view).offset(6)
            make.right.equalTo(view).offset(-6)
            make.height.equalTo(200)
        }
        
        // tableView
        let tableView        = UITableView()
        tableView.delegate   = self
        tableView.dataSource = self
        
        tableView.showsVerticalScrollIndicator = false
        
        tableView.registerNib(UINib(nibName: Constants.cellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(podiumView.snp_bottom)
            make.bottom.equalTo(view.snp_bottom)
            make.left.equalTo(podiumView.snp_left)
            make.right.equalTo(podiumView.snp_right)
        }
    }
    
    private func setupNavBar(){
        navigationItem.title = "视券贡献榜"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_back_white"), style: .Plain, target: self, action: Selector("popViewController"))
        
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let titleDict = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = titleDict
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.lt_setBackgroundColor(UIColor(hex: 0xF96520))
    }
    
    // MARK: - Target-actions
    func popViewController(){
        navigationController?.popViewControllerAnimated(true)
    }
}

extension PPCoinsContributionViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.cellIdentifier) as! PPPodiumUserTableViewCell
        
        // for testing
        cell.rankCountView.rankCount = 13
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
}