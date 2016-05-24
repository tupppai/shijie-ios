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
//import PLCameraStreamingKit

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
    var commentSourceArray = [PPLiveCommentModel]()
    var commentSourceQueue:Queue<PPLiveCommentModel> = Queue<PPLiveCommentModel>()
    let audienceDetailView = PPUserDetailView()
    
    var streamIDString:String?
    var previewView:UIView!
    var session:PLCameraStreamingSession?
    var stupidTimer:NSTimer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blackColor()
        previewView = UIView(frame: view.bounds)
        view .addSubview(previewView)
        view.sendSubviewToBack(previewView)
        
        setupViews()
        setupNotifications()
        setupRTMPPushSession()
        setupCommentGenerator()
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
   
    func tapClose() {
        
        
        let confirmEndLiveView = PPConfirmEndLiveView()
        
        confirmEndLiveView.cancelDismissLiveClosure = {
            [unowned confirmEndLiveView] in
            confirmEndLiveView.dismiss()
        }
        
        confirmEndLiveView.dismissLiveClosure = {
            [unowned confirmEndLiveView] in
            
            self.stupidTimer?.invalidate()
            self.session?.destroy()
            PPCloseMyAbandonedLiveRoom()
            
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
            
                    
//                ["title": self.titleForLive ]
                PPNetworkManager.postRequest("stream/create", parameters: ["title": self.titleForLive]).responseJSON(completionHandler: { (response) in
                    switch response.result {
                    case .Success(let JSON):
                        
                        guard let data = JSON.objectForKey("data") else{
                            return
                        }
                        self.streamIDString = data.objectForKey("id") as? String
                        let defaults = NSUserDefaults.standardUserDefaults()
                        defaults.setObject(self.streamIDString, forKey: "StreamIDStringKey")

                        
                        RCIM.sharedRCIM().receiveMessageDelegate = self
                        
                        
                        if let streamID = self.streamIDString  {
                            RCIMClient.sharedRCIMClient().joinChatRoom(streamID, messageCount: 10, success: {
                                
                                dispatch_async(dispatch_get_main_queue(),{
                                    print("成功加入聊天室 ID \(streamID)")
                                })
                                
                            }) { (errorCode) in
                                print("errorCode \(errorCode)")
                            }
                        }
                       
                        
                        
                        let json = JSON.objectForKey("data") as! [NSObject:AnyObject]
                        
                        let stream = PLStream(JSON: json)
                        let videoConfiguration = PLVideoStreamingConfiguration.defaultConfiguration()
                        let audioConfiguration = PLAudioStreamingConfiguration.defaultConfiguration()
                        self.session = PLCameraStreamingSession(videoConfiguration: videoConfiguration, audioConfiguration: audioConfiguration, stream: stream, videoOrientation: .Portrait)
                        self.session?.captureDevicePosition = PLCaptureDevicePosition.Front
                        self.session?.delegate = self
                        self.session?.previewView = self.previewView
                        self.session?.startWithCompleted({ (started) in
                        })
                        break
                        
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
        textInputBar.delegate = self
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
        
        audienceDetailView.buttonActionClosure = {
            [unowned self]
            (buttonType) in
            switch buttonType {
            case .Follow:
                HUD.flash(.Label("Follow"))
            case .PrivateMessage:
                HUD.flash(.Label("PrivateMessage"))
            case .Reply:
                HUD.flash(.Label("Reply"))
            case .HomePage:
                self.presentViewController(PPFriendViewController(), animated: true, completion: nil)
            }
        }
        
        audienceDetailView.showInView(view)
    }
}

// MARK:UITableViewDataSource,UITableViewDelegate

extension PPMyLiveViewController : UITableViewDataSource,UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(PPNewsCommentTableViewCell)) as! PPNewsCommentTableViewCell
        cell.injectSource(commentSourceArray[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentSourceArray.count
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
            tapClose()
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


extension PPMyLiveViewController:RCIMReceiveMessageDelegate ,PPTextInputBarDelegate{
    
    func onRCIMReceiveMessage(message: RCMessage!, left: Int32) {
     
        if message.content .isKindOfClass(RCTextMessage.classForCoder()) {
            let textMsg = message.content as! RCTextMessage
            
            let textArray = textMsg.content.componentsSeparatedByString("seperateOOXX#666")
            let sendername = textArray.first
            var content = ""
            if textArray.count > 1 {
                content = textArray[1]
            }
            
            let commentModel = PPLiveCommentModel()
            commentModel.content = content
            commentModel.senderId = message.senderUserId
            commentModel.senderName = sendername
            commentSourceQueue.enqueue(commentModel)
        }

    }
    
    func onRCIMCustomAlertSound(message: RCMessage!) -> Bool {
        return false
    }
    
  
    
    func textInputBar(textInputBar: PPTextInputBar, didTapSendButtonWithText text: String?) {
        
        
        let commentModel = PPLiveCommentModel()
        commentModel.content = text
        commentModel.senderId = "\(PPUserModel.shareInstance.ID)"
        commentModel.senderName = PPUserModel.shareInstance.name
        commentSourceQueue.enqueue(commentModel)
        
        
        if let streamID = streamIDString  {
            let msgContent = RCTextMessage()
            let content = "\(PPUserModel.shareInstance.name)seperateOOXX#666\(text ?? "")"
            msgContent.content = content
            
            RCIMClient.sharedRCIMClient().sendMessage(.ConversationType_CHATROOM, targetId: streamID, content: msgContent, pushContent: text, pushData: "离线时的 非显示 data", success: { (times) in
                print("sendMessage block times -> \(times)")
            }) { (errorCode, times) in
                print("sendMessage errorCode \(errorCode) times  \(times)")
            }
        }
    }
    
    func setupCommentGenerator() {
        stupidTimer = NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: #selector(PPMyLiveViewController.fireComment), userInfo: nil, repeats: true)
    }
    
    func fireComment() {
        
        if commentSourceQueue.isEmpty {
            return
        }
        guard let model = commentSourceQueue.dequeue() else{
            return
        }
        self.commentSourceArray.append(model)
        dispatch_async(dispatch_get_main_queue()) {
            let lastIndexPath = NSIndexPath(forRow: self.commentSourceArray.count - 1, inSection: 0)
            self.newsTableView.beginUpdates()
            self.newsTableView.insertRowsAtIndexPaths([lastIndexPath], withRowAnimation: .None)
            self.newsTableView.endUpdates()
            self.newsTableView.reloadData()
            self.newsTableView.scrollToRowAtIndexPath(lastIndexPath, atScrollPosition: .None, animated: true)
        }
    }
    
}


