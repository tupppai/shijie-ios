//
//  PPLiveWatchViewController.swift
//  live
//
//  Created by chenpeiwei on 3/14/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPLiveWatchViewController: UIViewController,PPLiveWatchControlCollectionViewDelegate {
    
    var player:PLPlayer!
    lazy var shareView:PPShareView = PPShareView()
    lazy var avatarCollectionView:UICollectionView = self.initializeAvatarCollectionView()
    var controlBottomView:PPLiveWatchControlCollectionView!
    var hostView:PPHostView!
    var receivedCoinView:PPHostReceivedCoinView!
    
    var giftShowsAnimateView:PPGiftShowsAnimateView!

    
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

        view.backgroundColor = UIColor.whiteColor()
//        setupPlayer()
        setupHeartBalloonGenerator()
        setupViews()

    }
    func setupViews() {
        
        giftShowsAnimateView = PPGiftShowsAnimateView()
//        giftShowsAnimateView.backgroundColor = UIColor.greenColor()
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
            make.height.equalTo(34)
        }
        
        setupControlBottomView()

        
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
            let xAnimateNumber = CGFloat(self.randInRange(-50...30))
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
    
    func randInRange(range: Range<Int>) -> Int {
        // arc4random_uniform(_: UInt32) returns UInt32, so it needs explicit type conversion to Int
        // note that the random number is unsigned so we don't have to worry that the modulo
        // operation can have a negative output
        return  Int(arc4random_uniform(UInt32(range.endIndex - range.startIndex))) + range.startIndex
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
            debugPrint("tap comment")
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

}

