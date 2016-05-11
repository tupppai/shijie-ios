//
//  PPLiveWatchViewController.swift
//  live
//
//  Created by chenpeiwei on 3/14/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class PPLiveWatchViewController: UIViewController {
    
    var player:PLPlayer?
    
    lazy var shareView:PPShareView = {
        let temp = PPShareView()
        temp.delegate = self
        return temp
    }()
    lazy var avatarCollectionView:UICollectionView = self.generateAvatarCollectionView()
    lazy var textInputBar:PPTextInputBar! = self.generateTextInputBar()
    lazy var giftView: PPGiftView = {
        let giftView      = PPGiftView()
        giftView.delegate = self
        return giftView
    }()
    
    var controlBottomView:PPLiveWatchControlCollectionView!
    var hostView:PPHostView!
    var receivedCoinView:PPHostReceivedCoinView!
    var giftShowsAnimateView:PPGiftShowsAnimateView!
    var newsTableView:UITableView!
    var heartFloatingView:PPHeartFloatingView!
    var textInputBarBottomContraint:Constraint!
    let detailView = PPUserDetailView()
    var numberOfNews = 5

    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    init() {
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
        self.edgesForExtendedLayout = .All
    }
    
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    override func viewDidLoad() {

        view.backgroundColor = UIColor.blackColor()
        setupPlayer()
        setupViews()
        setupCommentGenerator()
        setupNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        
    }
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pp_keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pp_keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func setupCommentGenerator() {
        NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: "fireComment", userInfo: nil, repeats: true)
    }
    
 
    func fireComment() {
        numberOfNews++
        let lastIndexPath = NSIndexPath(forRow: numberOfNews - 1, inSection: 0)
        newsTableView.beginUpdates()
        newsTableView.insertRowsAtIndexPaths([lastIndexPath], withRowAnimation: .Bottom)
        newsTableView.endUpdates()
        
//        newsTableView.scrollRectToVisible(CGRectMake(0, 0, 1, 1), animated: true)
        newsTableView.scrollToRowAtIndexPath(lastIndexPath, atScrollPosition: .Bottom, animated: true)
//        [self.tableView beginUpdates];
//        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        [self.tableView endUpdates];
//        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
    func toggleShareView() {
        if shareView.isShowing == true {
            shareView.dismiss()
        } else {
            shareView.show(inView: view, relativeView: self.controlBottomView.button_share)
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        if (touch.view !== shareView  ) {
            if shareView.isShowing == true {
                shareView .dismiss()
            }
        }
        
        if (touch.view !== textInputBar  ) {
           view.endEditing(true)
        }
    }
    
    func setupPlayer() {
        
        Manager.sharedInstance.request(.GET, "http://api.chupinlm.com/stream/create/test").responseJSON(completionHandler: { (response) in
            
            print("response!!!\(response)")
            
            switch response.result {
            case .Success(let JSON):
                let data = JSON as! NSDictionary

                guard let hosts = data.objectForKey("hosts") as? NSDictionary else{
                    return
                }

                guard let play = hosts.objectForKey("play") as? NSDictionary else{
                    return
                }

                guard let rtmpString = play.objectForKey("rtmp") as? String else {
                    return
                }

                guard let publishKey = data.objectForKey("publishKey") as? String else {
                    return
                }

                guard let hub = data.objectForKey("hub") as? String else {
                    return
                }
                guard let title = data.objectForKey("title") as? String else {
                    return
                }
                let urlString = "rtmp://" + rtmpString+"/"+hub+"/"+title + "?key=" + publishKey
                
                self.playerWithRTMPUrl(urlString)
                
            case .Failure(let error):
                print(error)
                
            }
            
            
            
            
        })

        
        
        
    }
    
    func playerWithRTMPUrl(urlString:String!) {
        
        print("urlString \(urlString)")
        let option = PLPlayerOption.defaultOption()
        option .setOptionValue(NSNumber(integer: 3), forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets)
        player = PLPlayer(URL: NSURL(string: urlString), option: option)
        player?.playerView?.frame = view.bounds
        player?.playerView?.backgroundColor = UIColor.whiteColor()
        player?.delegate = self
        view .addSubview((player?.playerView)!)
        view .sendSubviewToBack((player?.playerView)!)
        player? .play()
    }
}


extension PPLiveWatchViewController:PPLiveWatchControlCollectionViewDelegate {


    
    func controlCollectionView(controlCollectionView: PPLiveWatchControlCollectionView, didTapIndex index: Int) {
        switch(index){
        case 0:
            self.textInputBar.textField.becomeFirstResponder()
        case 1:
            toggleShareView()
        case 2:
            giftView.showInView(view)
        case 3:
            debugPrint("tap close")
            player?.stop()
            self.navigationController?.popViewControllerAnimated(true)
        default:
            debugPrint("tap error")
        }
    }
    
}

// MARK:UICollectionViewDataSource,UICollectionViewDelegate
extension PPLiveWatchViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:PPAvatarCollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier(String(PPAvatarCollectionCell), forIndexPath: indexPath) as! PPAvatarCollectionCell
        return cell
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        detailView.showInView(view)
    }
}


// MARK:UITableViewDataSource,UITableViewDelegate

extension PPLiveWatchViewController : UITableViewDataSource,UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(PPNewsCommentTableViewCell))
        return (cell)!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfNews
    }
    
}

// MARK:SetupViews

extension PPLiveWatchViewController {
    
    func setupViews() {
        setupBottomControlPanelView()
        setupGiftShowsAnimateView()
        setupHostCollectionViews()
        setupNewsTableView()
        setupHeartFloatingView()
    }
    
    
    func generateTextInputBar() -> PPTextInputBar {
        
        let textInputBar = PPTextInputBar()
        textInputBar.hidden = true
        view.addSubview(textInputBar)
        
        textInputBar.snp_makeConstraints { (make) -> Void in
            make.leading.trailing.equalTo(view)
            textInputBarBottomContraint = make.bottom.equalTo(view).constraint
            make.height.equalTo(textInputBar.height)
        }
        return textInputBar
        
    }
    
    func setupNewsTableView () {
        newsTableView = UITableView()
        newsTableView.backgroundColor = UIColor.clearColor()
        newsTableView.delegate = self
        newsTableView.showsHorizontalScrollIndicator = false
        newsTableView.showsVerticalScrollIndicator = false
        newsTableView.dataSource = self
        newsTableView.separatorStyle  = .None
        newsTableView.tableFooterView = UIView()
        newsTableView.rowHeight = UITableViewAutomaticDimension
        newsTableView.estimatedRowHeight = 40
        
        newsTableView .registerClass(PPNewsCommentTableViewCell.self, forCellReuseIdentifier: String(PPNewsCommentTableViewCell))
        view .addSubview(newsTableView)
        
        newsTableView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(0.6*ScreenSize.SCREEN_WIDTH)
            make.height.equalTo(160)
            make.leading.equalTo(view).offset(8)
            make.bottom.equalTo(textInputBar.snp_top).offset(-15)
        }
    }

    
    func setupGiftShowsAnimateView() {
        giftShowsAnimateView = PPGiftShowsAnimateView()
        view.addSubview(giftShowsAnimateView)
        giftShowsAnimateView.snp_makeConstraints { (make) -> Void in
            make.leading.trailing.equalTo(view)
            make.centerY.equalTo(view)
            make.height.equalTo(110)
        }
        giftShowsAnimateView.show()
    }
    func setupHostCollectionViews() {
        hostView = PPHostView()
        receivedCoinView = PPHostReceivedCoinView()
        view.addSubview(hostView)
        view .addSubview(avatarCollectionView)
        view .addSubview(receivedCoinView)
        hostView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(117)
            make.height.equalTo(45)
            make.leading.equalTo(view).offset(12)
            make.top.equalTo(view).offset(22)
        }
        receivedCoinView.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(hostView)
            make.top.equalTo(hostView.snp_bottom).offset(14)
            make.height.equalTo(22)
            make.width.greaterThanOrEqualTo(80)
        }
        
        avatarCollectionView.snp_makeConstraints { (make) -> Void in
            make.trailing.equalTo(3)
            make.leading.equalTo(hostView.snp_trailing).offset(5)
            make.centerY.equalTo(hostView)
            make.height.equalTo(35)
        }
    }
    func setupBottomControlPanelView() {
        controlBottomView = PPLiveWatchControlCollectionView()
        controlBottomView.delegate = self
        view .addSubview(controlBottomView)
        controlBottomView.snp_makeConstraints { (make) -> Void in
            make.leading.trailing.bottom.equalTo(view)
            make.height.equalTo(35)
        }
    }
    
    func setupHeartFloatingView() {
        heartFloatingView = PPHeartFloatingView()
        heartFloatingView.backgroundColor = UIColor.clearColor()
        
        view.addSubview(heartFloatingView)
        heartFloatingView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(100)
            make.height.equalTo(ScreenSize.SCREEN_HEIGHT*0.5)
            make.bottom.equalTo(controlBottomView.snp_top)
            make.centerX.equalTo(controlBottomView.button_sendGift.snp_centerX)
        }
        
        heartFloatingView.setupHeartBalloonGenerator()
        
    }
    
    func generateAvatarCollectionView() -> UICollectionView {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSizeMake(35, 35)
        layout.minimumLineSpacing = 5
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.registerClass(PPAvatarCollectionCell.self, forCellWithReuseIdentifier: String(PPAvatarCollectionCell))
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clearColor()
        
        return collectionView
        
    }

    
}

// MARK:Custom Delegate

extension PPLiveWatchViewController: PPGiftViewDelegate,PPShareViewDelegate,PLPlayerDelegate{
    
    func player(player: PLPlayer, statusDidChange state: PLPlayerStatus) {
        print("player statusDidChange \(state)")
    }
    func player(player: PLPlayer, stoppedWithError error: NSError?) {
        print("player stoppedWithError \(error)")
    }
    func player(player: PLPlayer, willEndBackgroundTask isExpirationOccured: Bool) {
        print("player isExpirationOccured")
    }
    func playerWillBeginBackgroundTask(player: PLPlayer) {
        print("player playerWillBeginBackgroundTask")
    }
    
    
    func giftViewDidChargeMoney(giftView: PPGiftView) {
        debugPrint("准备跳往充值页面")
    }
    
    func giftViewDidSendDiamond(giftView: PPGiftView, model: PPGiftModel) {
        debugPrint("送出\(model.diamondCount)颗钻石")
    }
    
    func shareView(shareView: PPShareView, didTap index: Int) {
        switch(index) {
        case 1:
            //sina
            if !MonkeyKing.isAppInstalled(.Weibo) {
                print("没有安装微博")
                return
            }
            let message = MonkeyKing.Message.Weibo(.Default(info: (
                title: "News",
                description: "Hello Yep",
                thumbnail: UIImage(named: "rabbit"),
                media: .URL(NSURL(string: "http://soyep.com")!)
                ), accessToken: nil))
            MonkeyKing.shareMessage(message) { result in
                print("result: \(result)")
            }
          
        case 2:
            //wechat moments
            if !MonkeyKing.isAppInstalled(.WeChat) {
                print("没有安装微信")
                return
            }

            let message = MonkeyKing.Message.WeChat(.Timeline(info: (
                title: "Session",
                description: "Hello Session",
                thumbnail: UIImage(named: "rabbit"),
                media: .URL(NSURL(string: "http://www.apple.com/cn")!)
            )))
            
            MonkeyKing.shareMessage(message) { success in
                print("shareURLToWeChatSession success: \(success)")
            }
        case 3:
            //wechat session
            if !MonkeyKing.isAppInstalled(.WeChat) {
                print("没有安装微信")
                return
            }
            let message = MonkeyKing.Message.WeChat(.Session(info: (
                title: "Session",
                description: "Hello Session",
                thumbnail: UIImage(named: "demo"),
                media: .URL(NSURL(string: "http://www.apple.com/cn")!)
            )))
            
            MonkeyKing.shareMessage(message) { success in
                print("shareURLToWeChatSession success: \(success)")
            }

        case 4:
            //QQ
            if !MonkeyKing.isAppInstalled(.QQ) {
                print("没有安装QQ")
                return
            }
            let info = MonkeyKing.Info(
                title: "QQ URL, \(NSUUID().UUIDString)",
                description: "apple.com/cn, \(NSUUID().UUIDString)",
                thumbnail: UIImage(named: "demo"),
                media: .URL(NSURL(string: "http://www.apple.com/cn")!)
            )
            let message :MonkeyKing.Message? = MonkeyKing.Message.QQ(.Friends(info: info))
            
            if let message = message{
                MonkeyKing.shareMessage(message) { result in
                    print("result: \(result)")
                }
            }
            
        case 5:
            //QZone
            if !MonkeyKing.isAppInstalled(.QQ) {
                print("没有安装QQ")
                return
            }
            let info = MonkeyKing.Info(
                title: "QQ URL, \(NSUUID().UUIDString)",
                description: "apple.com/cn, \(NSUUID().UUIDString)",
                thumbnail: UIImage(named: "demo"),
                media: .URL(NSURL(string: "http://www.apple.com/cn")!)
            )
            let message :MonkeyKing.Message? = MonkeyKing.Message.QQ(.Zone(info: info))
            
            if let message = message{
                MonkeyKing.shareMessage(message) { result in
                    print("result: \(result)")
                }
            }

        default: break
        }
    }
}



extension PPLiveWatchViewController {
    
    
    func pp_keyboardWillShow(sender:NSNotification?) {
        let keyboardHeight = properKeyboardHeightFromNotification(sender)
        textInputBarBottomContraint.updateOffset(-keyboardHeight-2)
        self.textInputBar.hidden = false
        UIView.animateWithDuration(0.5) { () -> Void in
            self.giftShowsAnimateView.hidden = true
            self.textInputBar?.layoutIfNeeded()
            self.newsTableView.layoutIfNeeded()
        }
    }
    
    func pp_keyboardWillHide(sender:NSNotification?) {
        textInputBarBottomContraint.updateOffset(0)
        UIView.animateWithDuration(0.2) { () -> Void in
            self.giftShowsAnimateView.hidden = false
            self.textInputBar.hidden = true
            self.newsTableView.layoutIfNeeded()
        }
    }
    
    func properKeyboardHeightFromNotification(notification:NSNotification?)->CGFloat {
        if let notification = notification {
            let keyboardRect = notification.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue
            let relativeKeyboardRect = view.convertRect(keyboardRect!, fromView: nil)
            let viewHeight = CGRectGetHeight(view.bounds)
            let keyboardMinY = CGRectGetMinY(relativeKeyboardRect)
            let keyboardHeight = max(0.0 , viewHeight - keyboardMinY)
            return keyboardHeight
        }
        return 0
    }
    
}
