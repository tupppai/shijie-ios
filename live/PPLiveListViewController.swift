//
//  PPLiveListViewController.swift
//  live
//
//  Created by chenpeiwei on 3/15/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPLiveListViewController: UIViewController {
    lazy var tableView:UITableView = self.initializeTableView()
     var navigationBar:UIView!

    override func viewDidLoad() {
        self.edgesForExtendedLayout = .None
        self.initNavigationBar()
        
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.bottom.leading.trailing.equalTo(view)
            make.top.equalTo(navigationBar.snp_bottom)
        }
    }
    func setupNavTitleView() {
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    func initNavigationBar() {

        navigationBar = UIView()
        view .addSubview(navigationBar)
        let navBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        navigationBar.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(20)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(navBarHeight)
        }
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        label.text = "直播"
        label.font = UIFont.systemFontOfSize(17)
        label.textAlignment = .Center
        navigationBar .addSubview(label)
        label.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(navigationBar)
        }
        
//        CALayer *bottomBorder = [CALayer layer];
//        
//        bottomBorder.frame = CGRectMake(0.0f, 43.0f, toScrollView.frame.size.width, 1.0f);
//        
//        bottomBorder.backgroundColor = [UIColor colorWithWhite:0.8f
//            alpha:1.0f].CGColor;
//        
//        [toScrollView.layer addSublayer:bottomBorder];
        
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRectMake(0, navBarHeight-1, ScreenSize.SCREEN_WIDTH, 0.5)
        bottomBorder.backgroundColor = UIColor(hex: 0xe7e7e7).CGColor
        navigationBar.layer.addSublayer(bottomBorder)

    }

}

// MARK:TableView Functions
extension PPLiveListViewController:UITableViewDataSource,UITableViewDelegate {
    
    func initializeTableView()->UITableView {
        let temporaryTableView = UITableView(frame: CGRectZero, style: .Plain)
        temporaryTableView.delegate = self
        temporaryTableView.dataSource = self
        temporaryTableView.registerClass(PPLivesTableViewCell.self, forCellReuseIdentifier: "PPLiveTableViewCellIndentifier")
        temporaryTableView.tableFooterView = UIView()
        temporaryTableView.separatorStyle = .None
        return temporaryTableView
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
  
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PPLiveTableViewCellIndentifier", forIndexPath: indexPath)
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return ScreenSize.SCREEN_WIDTH + 64
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = PPLiveWatchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}