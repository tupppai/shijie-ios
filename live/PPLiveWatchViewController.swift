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
    lazy var shareView:PPSocialShareView = PPSocialShareView()
    
    var controlBottomView:PPLiveWatchControlCollectionView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
        self.edgesForExtendedLayout = .All
    }
    func injected() {
        showSocialShareView()
    }
    
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    override func viewDidLoad() {

        view.backgroundColor = UIColor.whiteColor()
        setupPlayer()
        setupControlBottomView()
        setupHeartBalloonGenerator()
    }
    
    func setupHeartBalloonGenerator() {
        NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "fireBallon", userInfo: nil, repeats: true)
    }
    
    func fireBallon() {
        let delaySec = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delaySec * CGFloat(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            let heart = PPHeartView()
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
    
    func showSocialShareView() {
        shareView.show(inView: view, relativeView: self.controlBottomView.button_share)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            if (touch.view !== shareView  ) {
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
        player.playerView?.hidden = true
        player .play()
    }
    
    func setupControlBottomView() {
        controlBottomView = PPLiveWatchControlCollectionView()
        controlBottomView.delegate = self
        view .addSubview(controlBottomView)
        controlBottomView.snp_makeConstraints { (make) -> Void in
            make.leading.trailing.bottom.equalTo(view)
            make.height.equalTo(34)
        }
    }
}


extension PPLiveWatchViewController {
    func controlCollectionView(controlCollectionView: PPLiveWatchControlCollectionView, didTapIndex index: Int) {
        switch(index) {
        case 0 :
            debugPrint("tap comment")
        case 1 :
            debugPrint("tap share")
            showSocialShareView()
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
