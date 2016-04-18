//
//  PPMyLiveViewController.swift
//  live
//
//  Created by chenpeiwei on 3/10/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit
import VideoCore
import SnapKit

class PPMyLiveViewController: UIViewController,VCSessionDelegate {
    
    lazy var avatarCollectionView:UICollectionView = self.initializeAvatarCollectionView()
    var controlBottomView:PPMyLiveControlCollectionView!
    var hostView:PPHostView!
    var receivedCoinView:PPHostReceivedCoinView!
    var giftShowsAnimateView:PPGiftShowsAnimateView!
    var newsTableView:UITableView!
    var textInputBar:PPTextInputBar!
    var heartFloatingView:PPHeartFloatingView!
    var textInputBarBottomContraint:Constraint!
    let detailView = PPUserDetailView()
    var numberOfNews = 5
    
    var previewView:UIView!
    var session:VCSimpleSession = VCSimpleSession(videoSize: CGSize(width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT), frameRate: 15, bitrate: 500000, useInterfaceOrientation: true, cameraState: .Front, aspectMode: VCAspectMode.AspectModeFit)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupViews()

        previewView = UIView(frame: view.bounds)
        view .addSubview(previewView)
        view.sendSubviewToBack(previewView)
        self.previewView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        previewView.addSubview(session.previewView)
        
        session.previewView.frame = previewView.bounds
        session.cameraState = VCCameraState.Front
        session.delegate = self

        connect()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        session.delegate = nil;
    }
    
    func dismissSelf() {
        session .endRtmpSession()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func switchCamera() {
        switch session.cameraState {
        case .Front:
            session.cameraState = .Back
            self.previewView.transform = CGAffineTransformMakeScale(1.0, 1.0);

        case .Back:
            session.cameraState = .Front
            self.previewView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        }
    }
     func connect() {
        switch session.rtmpSessionState {
        case .None, .PreviewStarted, .Ended, .Error:
            session.startRtmpSessionWithURL("rtmp://w.gslb.lecloud.com/live", andStreamKey: "201604183000000s199?sign=5d802f26e21c3737828ca3c9c53910bd&tm=20160418113125")
            //            /119.29.142.208/live/cam2
        default:
            session.endRtmpSession()
            break
        }
    }
    
    
    
    func switchFilter() {
        switch self.session.filter {
            
        case .Normal:
            self.session.filter = .Gray
            
        case .Gray:
            self.session.filter = .InvertColors
            
        case .InvertColors:
            self.session.filter = .Sepia
            
        case .Sepia:
            self.session.filter = .Fisheye
            
        case .Fisheye:
            self.session.filter = .Glow
            
        case .Glow:
            self.session.filter = .Normal
        }
    }
    
    func connectionStatusChanged(sessionState: VCSessionState) {
        debugPrint("connectionStatusChanged sessionState\(sessionState)")
        switch sessionState {
        case .None:
            print("connectionStatusChanged None")
            break
        case .PreviewStarted:
            print("connectionStatusChanged PreviewStarted")
            break
        case .Started:
            print("connectionStatusChanged Started")
            break
        case .Starting:
            print("connectionStatusChanged Starting")
            break
        case .Ended:
            print("connectionStatusChanged Ended")
            connect()
            break
        case .Error:
            print("connectionStatusChanged Error reconnect")
            session .endRtmpSession()
            break

        }
    }
}

// MARK:SetupViews

extension PPMyLiveViewController {
    
    func setupViews() {
        setupBottomControlPanelView()
        setupGiftShowsAnimateView()
        setupHostCollectionViews()
        setupTextInputBar()
        setupNewsTableView()
        setupHeartFloatingView()
    }
    
    
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
        controlBottomView = PPMyLiveControlCollectionView()
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
            make.centerX.equalTo(controlBottomView.button_camera.snp_centerX)
        }
        
        heartFloatingView.setupHeartBalloonGenerator()
        
    }
    
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
    
    
}




// MARK:UICollectionViewDataSource,UICollectionViewDelegate
extension PPMyLiveViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    
    
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

// MARK:UITableViewDataSource,UITableViewDelegate

extension PPMyLiveViewController : UITableViewDataSource,UITableViewDelegate {
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

extension PPMyLiveViewController:PPMyLiveControlCollectionViewDelegate {

    
    func myLiveControlCollectionView(myliveControlCollectionView: PPMyLiveControlCollectionView, didTapIndex index: Int) {
        switch(index) {
        case 0 :
            self.textInputBar.textField.becomeFirstResponder()
        case 1 :
            switchCamera()
        case 2 :
            self.dismissSelf()
        default:
            debugPrint("tap error")
        }
    }
    
    
}
