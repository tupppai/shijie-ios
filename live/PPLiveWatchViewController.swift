//
//  PPLiveWatchViewController.swift
//  live
//
//  Created by chenpeiwei on 3/14/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit
import SnapKit
class PPLiveWatchViewController: UIViewController,PPLiveWatchControlCollectionViewDelegate {
    
    var player:PLPlayer!
    lazy var shareView:PPShareView = PPShareView()
    lazy var avatarCollectionView:UICollectionView = self.initializeAvatarCollectionView()
    var controlBottomView:PPLiveWatchControlCollectionView!
    var hostView:PPHostView!
    var receivedCoinView:PPHostReceivedCoinView!
    var giftShowsAnimateView:PPGiftShowsAnimateView!
    var newsTableView:UITableView!
    var textInputBar:PPTextInputBar!
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
        setupHeartBalloonGenerator()
        setupViews()
        setupCommentGenerator()
        setupNotifications()
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
    func setupViews() {
        
        giftShowsAnimateView = PPGiftShowsAnimateView()
        view.addSubview(giftShowsAnimateView)
        giftShowsAnimateView.snp_makeConstraints { (make) -> Void in
            make.leading.trailing.equalTo(view)
            make.centerY.equalTo(view)
            make.height.equalTo(110)
        }
        giftShowsAnimateView.show()
        
        hostView = PPHostView()
        controlBottomView = PPLiveWatchControlCollectionView()
        controlBottomView.delegate = self
        receivedCoinView = PPHostReceivedCoinView()
        view.addSubview(hostView)
        view .addSubview(avatarCollectionView)
        view.addSubview(hostView)
        view .addSubview(receivedCoinView)
        view .addSubview(controlBottomView)


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
        controlBottomView.snp_makeConstraints { (make) -> Void in
            make.leading.trailing.bottom.equalTo(view)
            make.height.equalTo(35)
        }
        
        setupControlBottomView()
        setupTextInputBar()
        setupNewsTableView()

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
    
    
    func setupHeartBalloonGenerator() {
        NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "fireBallon", userInfo: nil, repeats: true)
    }
    
    func fireBallon() {
        let delaySec = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delaySec * CGFloat(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            let heart = PPLovingHeartView()
            let sendGiftFrameInView = self.controlBottomView.button_sendGift.superview?.convertRect(self.controlBottomView.button_sendGift.frame, toView: self.view)
            heart.frame = CGRectMake((sendGiftFrameInView?.origin.x)!, (sendGiftFrameInView?.origin.y)!-20, 20, 20)
            self.view .addSubview(heart)
            
            var frame = heart.frame
            let xAnimateNumber = CGFloat(randInRange(-50...30))
            if abs(xAnimateNumber)>25 {
                heart.animation = "swing"
                heart.curve = "spring"
                heart.force =  1.0
                heart.duration =  8
                heart.animate()
            }
            else if abs(xAnimateNumber)>10 {
                heart.animation = "shake"
                heart.curve = "linear"
                heart.force =  1.0
                heart.duration =  8
                heart.animate()
            } else {
                
            }
            frame.origin.x += xAnimateNumber
            
            
            UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
                heart.frame = frame
                }, completion: { (finished) -> Void in
            })
            
            UIView.animateWithDuration(8.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                heart.frame = CGRectMake((sendGiftFrameInView?.origin.x)!, ScreenSize.SCREEN_HEIGHT*0.6, 20, 20)
                heart.alpha = 0.0
                }, completion: { (finished) -> Void in
                    heart .removeFromSuperview()
            })
        }
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
        
        let option = PLPlayerOption.defaultOption()
        option .setOptionValue(NSNumber(integer: 3), forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets)
        player = PLPlayer(URL: NSURL(string: "rtmp://119.29.142.208/live/peiwei"), option: option)
        view .addSubview(player.playerView!)
        view .sendSubviewToBack(player.playerView!)
        player .play()
    }
    
    func setupControlBottomView() {

    }
}


extension PPLiveWatchViewController {
    func controlCollectionView(controlCollectionView: PPLiveWatchControlCollectionView, didTapIndex index: Int) {
        switch(index) {
        case 0 :
            self.textInputBar.textField.becomeFirstResponder()
        case 1 :
            debugPrint("tap share")
            toggleShareView()
        case 2 :
            debugPrint("tap sendGift")            
            
        case 3 :
            debugPrint("tap close")
            self.navigationController?.popViewControllerAnimated(true)
        default:
            debugPrint("tap error")
        }
    }
}

// MARK:Avatar CollectionView
extension PPLiveWatchViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    
    func initializeAvatarCollectionView() -> UICollectionView {
        
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
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:PPAvatarCollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier(String(PPAvatarCollectionCell), forIndexPath: indexPath) as! PPAvatarCollectionCell
        return cell
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        detailView.showInView(view)
    }
}

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

extension PPLiveWatchViewController {
    
    func setupTextInputBar() {
        textInputBar = PPTextInputBar()
        textInputBar.hidden = true
        view.addSubview(textInputBar)
        
        textInputBar.snp_makeConstraints { (make) -> Void in
            make.leading.trailing.equalTo(view)
            textInputBarBottomContraint = make.bottom.equalTo(view).constraint
            make.height.equalTo(textInputBar.height)
        }
    }
    
    func pp_keyboardWillShow(sender:NSNotification?) {
        let keyboardHeight = properKeyboardHeightFromNotification(sender)
        textInputBarBottomContraint.updateOffset(-keyboardHeight)
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
