//
//  PPMyLiveViewController.swift
//  live
//
//  Created by chenpeiwei on 3/10/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import PKHUD
import PLCameraStreamingKit

class PPMyLiveViewController: UIViewController {
    
    var titleForLive = ""
    
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
    var session:PLCameraStreamingSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blackColor()
        previewView = UIView(frame: view.bounds)
        view .addSubview(previewView)
        view.sendSubviewToBack(previewView)
        
        setupViews()
        setupNotifications()
        setupRTMPPushSession()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
       
        
        if (touch.view !== textInputBar && textInputBar.textField.isFirstResponder()  ) {
            view.endEditing(true)
        }
    }
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationDidEnterBackground", name: UIApplicationDidEnterBackgroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillEnterForeground", name: UIApplicationWillEnterForegroundNotification, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pp_keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pp_keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    deinit {
        print("nice!  Mylive is deinit")
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationWillEnterForegroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationDidEnterBackgroundNotification, object: nil)
        session?.destroy()
    }
   
    func closeLiveAction() {
        
        session?.destroy()
        
        let confirmEndLiveView = PPConfirmEndLiveView()
        
        confirmEndLiveView.cancelDismissLiveClosure = {
            [unowned confirmEndLiveView] in
            confirmEndLiveView.dismiss()
        }
        
        confirmEndLiveView.dismissLiveClosure = {
            [unowned confirmEndLiveView] in
            confirmEndLiveView.dismiss()
            let stripperEndLiveView = PPLiveFinishedStripperView()
            
            stripperEndLiveView.goHomeClosure = {
                [unowned stripperEndLiveView,
                 unowned self] in
                stripperEndLiveView.dismiss()
                
                self.dismissViewControllerAnimated(true,
                                                   completion: { 
                                                    // toggle to first tab
                })
                
            }
            stripperEndLiveView.show()
        }
        
        confirmEndLiveView.show()
    }
    
    func applicationWillEnterForeground() {
        session?.startWithCompleted { (started) in
            
        }
    }
    func applicationDidEnterBackground() {
        session?.stop()
    }
    
    func switchCamera() {
//        switch session.cameraState {
//        case .Front:
//            session.cameraState = .Back
//            self.previewView.transform = CGAffineTransformMakeScale(1.0, 1.0);
//            
//        case .Back:
//            session.cameraState = .Front
//            self.previewView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//        }
    }
  
    
    
    func setupRTMPPushSession() {
        
        PLCameraStreamingSession.requestCameraAccessWithCompletionHandler { (granted) in
            if granted {
                
//                PPNetworkManager.postRequest("stream/create", parameters: ["title": self.titleForLive ]).responseJSON(completionHandler: { (response) in
//                    switch response.result {
//                    case .Success(let JSON):
//                        let json = JSON as! [NSObject:AnyObject]
//                        let stream = PLStream(JSON: json)
//                        let videoConfiguration = PLVideoStreamingConfiguration.defaultConfiguration()
//                        let audioConfiguration = PLAudioStreamingConfiguration.defaultConfiguration()
//                        self.session = PLCameraStreamingSession(videoConfiguration: videoConfiguration, audioConfiguration: audioConfiguration, stream: stream, videoOrientation: .Portrait)
//                        self.session?.captureDevicePosition = PLCaptureDevicePosition.Front
//                        self.session?.delegate = self
//                        self.session?.previewView = self.previewView
//                        self.session?.startWithCompleted({ (started) in
//                        })
//                        
//                    case .Failure(let error):
//                        print(error)
//                    }
//                })

                Manager.sharedInstance.request(.GET, "http://api.chupinlm.com/stream/create/test").responseJSON(completionHandler: { (response) in

                    switch response.result {
                        case .Success(let JSON):
                            let json = JSON as! [NSObject:AnyObject]
                            let stream = PLStream(JSON: json)
                            let videoConfiguration = PLVideoStreamingConfiguration.defaultConfiguration()
                            let audioConfiguration = PLAudioStreamingConfiguration.defaultConfiguration()
                            self.session = PLCameraStreamingSession(videoConfiguration: videoConfiguration, audioConfiguration: audioConfiguration, stream: stream, videoOrientation: .Portrait)
                            self.session?.captureDevicePosition = PLCaptureDevicePosition.Front
                            self.session?.delegate = self
                            self.session?.previewView = self.previewView
                            self.session?.startWithCompleted({ (started) in
                            })
                            
                        case .Failure(let error):
                            print(error)
                    }
                    
                    
                })
             }
            else {
                print("没有授权see使用你的相机和麦克风")
            }

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
            self.closeLiveAction()
        default:
            debugPrint("tap error")
        }
    }
    
    
}


extension PPMyLiveViewController {
    
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

extension PPMyLiveViewController:PLCameraStreamingSessionDelegate {

    func cameraStreamingSession(session: PLCameraStreamingSession!, didDisconnectWithError error: NSError!) {
        print("PLCameraStreamingSessionDelegate didDisconnectWithError -> \(error)")
    }
    func cameraStreamingSession(session: PLCameraStreamingSession!, streamStateDidChange state: PLStreamState) {
        print("PLCameraStreamingSessionDelegate streamStateDidChange state \(state.rawValue)")

    }
    func cameraStreamingSession(session: PLCameraStreamingSession!, streamStatusDidUpdate status: PLStreamStatus!) {
        print("PLCameraStreamingSessionDelegate streamStatusDidUpdate status \(status)")

    }
    func cameraStreamingSession(session: PLCameraStreamingSession!, didGetCameraAuthorizationStatus status: PLAuthorizationStatus) {
        print("PLCameraStreamingSessionDelegate didGetCameraAuthorizationStatus status \(status)")
    }
    func cameraStreamingSession(session: PLCameraStreamingSession!, didGetMicrophoneAuthorizationStatus status: PLAuthorizationStatus) {
        print("PLCameraStreamingSessionDelegate didGetMicrophoneAuthorizationStatus status\(status)")

    }
    
}
