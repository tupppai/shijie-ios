//
//  PPLiveListViewController.swift
//  live
//
//  Created by chenpeiwei on 3/15/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit
import RealmSwift

class PPLiveListViewController: UIViewController {
    lazy var tableView:UITableView = self.initializeTableView()
     var navigationBar:UIView!
    var liveModelSourceArray = [PPLiveModel]()
    var refreshControl:CBStoreHouseRefreshControl!
    override func viewDidLoad() {
        self.edgesForExtendedLayout = .All
        self.initNavigationBar()
        
        setupRefreshControl()
        
        tableView.backgroundColor = UIColor.whiteColor()
        view.addSubview(tableView)
        view.sendSubviewToBack(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.bottom.leading.trailing.equalTo(view)
            make.top.equalTo(navigationBar.snp_bottom).offset(-24)
        }
        tableView.alwaysBounceVertical = true

        operateLiveModelSourceFromRemote()
    }
    
    
    func setupRefreshControl() {
        refreshControl = CBStoreHouseRefreshControl.attachToScrollView(tableView, target: self, refreshAction: #selector(PPLiveListViewController.operateLiveModelSourceFromRemote), plist: "storehouserefresh", color: UIColor.blackColor(), lineWidth: 1, dropHeight: 80, scale: 1, horizontalRandomness: 100, reverseLoadingAnimation: true, internalAnimationFactor: 1.0)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        refreshControl.scrollViewDidScroll()
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        refreshControl.scrollViewDidEndDragging()
    }
    
    func operateLiveModelSourceFromRemote() {
        PPNetworkManager.postRequest("stream/list", parameters: nil).responseJSON
            { response in
                self.refreshControl.finishingLoading()
                switch response.result {
                case .Success(let JSON):
                    let response = JSON as! NSDictionary
                    if let errCode = response.objectForKey("errCode") as? Int {
                        if errCode != 0 {
                            return
                        }
                    }
                    
                    self.liveModelSourceArray.removeAll()
                    
                    if let dataArray = response.objectForKey("data") as? NSArray {
                        for data in dataArray {
                            let model = PPLiveModel()
                            model.ID = data.objectForKey("id") as? Int ?? 0
                            model.showImageUrl = data.objectForKey("imgUrl") as? String ?? ""
                            model.playURL = data.objectForKey("playUrl") as? String ?? ""
                            model.title = data.objectForKey("title") as? String ?? ""
                            model.coins = data.objectForKey("coin") as? Int ?? 0
                            model.watchedCount = data.objectForKey("watchCnt") as? Int ?? 0
                            model.audienceCount = data.objectForKey("audienceCount") as? Int ?? 0
                            model.streamID = data.objectForKey("streamId") as? String ?? ""
                            if let subData1 = data.objectForKey("user") as? NSDictionary {
                                model.userModel = PPUserModel()
                                model.userModel?.ID = subData1.objectForKey("id") as? Int ?? 0
                                model.userModel?.avatarUrl = subData1.objectForKey("avatar") as? String ?? ""
                                model.userModel?.name = subData1.objectForKey("nickname") as? String ?? ""
                            }
                            
                            self.liveModelSourceArray.append(model)
                            
                            let realm = try! Realm()
                            try! realm.write {
                                realm.add(model, update: true)
                            }
                        }
                        
                        self.tableView.reloadData()
                        
                    }
                    
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
        }

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
        navigationBar.backgroundColor = UIColor.whiteColor()
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        label.text = "直播"
        label.font = UIFont.systemFontOfSize(17)
        label.textAlignment = .Center
        navigationBar .addSubview(label)
        label.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(navigationBar)
        }
        
        
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRectMake(0, navBarHeight-1, ScreenSize.SCREEN_WIDTH, 0.5)
        bottomBorder.backgroundColor = UIColor(hex: 0xe7e7e7).CGColor
        navigationBar.layer.addSublayer(bottomBorder)

    }

}

// MARK:TableView Functions
extension PPLiveListViewController:UITableViewDataSource,UITableViewDelegate {
    
    func initializeTableView()->UITableView {
        let temporaryTableView = UITableView(frame: view.frame, style: .Plain)
        temporaryTableView.backgroundColor = UIColor(hex: 0xF4F4F4)
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
        return liveModelSourceArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PPLiveTableViewCellIndentifier", forIndexPath: indexPath) as! PPLivesTableViewCell
        cell.injectSourceFromModel(liveModelSourceArray[indexPath.row])
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return ScreenSize.SCREEN_WIDTH + 64
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = PPLiveWatchViewController()
        vc.liveModel = liveModelSourceArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}