//
//  PPLiveWatchViewController.swift
//  live
//
//  Created by chenpeiwei on 3/14/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPLiveWatchViewController: UIViewController {
    
    var player:PLPlayer!
    
    var button_comment:UIButton!
    var button_share:UIButton!
    var button_sendGift:UIButton!
    var button_close:UIButton!

    
     init() {
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }

     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    override func viewDidLoad() {
        self.edgesForExtendedLayout = .All

        self.hidesBottomBarWhenPushed = true
        view.backgroundColor = UIColor.whiteColor()
        
        let option = PLPlayerOption.defaultOption()
        option .setOptionValue(NSNumber(integer: 3), forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets)
        player = PLPlayer(URL: NSURL(string: "rtmp://119.29.142.208/live/peiwei"), option: option)
        view .addSubview(player.playerView!)
        view .sendSubviewToBack(player.playerView!)
        player .play()
        
        setupBottomControlButtonPanel()


    }
    override func viewWillAppear(animated: Bool) {
        
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
//
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBarHidden = true
    }
//
//    override func viewWillDisappear(animated: Bool) {
//        self.navigationController?.navigationBarHidden = false
//    }
  
}


extension PPLiveWatchViewController {
    
    func setupBottomControlButtonPanel() {
        button_comment = UIButton(type: .Custom)
        button_share = UIButton(type: .Custom)
        button_sendGift = UIButton(type: .Custom)
        button_close = UIButton(type: .Custom)
        button_comment .setImage(UIImage(named: "live-comment"), forState: .Normal)
        button_share .setImage(UIImage(named: "live-share"), forState: .Normal)
        button_sendGift .setImage(UIImage(named: "live-sendgift"), forState: .Normal)
        button_close .setImage(UIImage(named: "live-close"), forState: .Normal)
        
        
        button_close .addTarget(self, action: "tapButton_close", forControlEvents: .TouchUpInside)
        button_sendGift .addTarget(self, action: "tapButton_sendGift", forControlEvents: .TouchUpInside)
        button_comment .addTarget(self, action: "tapButton_comment", forControlEvents: .TouchUpInside)
        button_share .addTarget(self, action: "tapButton_share", forControlEvents: .TouchUpInside)

        view .addSubview(button_comment)
        view .addSubview(button_share)
        view .addSubview(button_sendGift)
        view .addSubview(button_close)

        button_comment.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(34)
            make.leading.equalTo(view).offset(12)
            make.bottom.equalTo(view).offset(-12)
        }
        button_close.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(34)
            make.trailing.equalTo(view).offset(-12)
            make.bottom.equalTo(view).offset(-12)
        }
        button_sendGift.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(34)
            make.trailing.equalTo(button_close.snp_leading).offset(-15)
            make.bottom.equalTo(view).offset(-12)
        }
        button_share.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(34)
            make.trailing.equalTo(button_sendGift.snp_leading).offset(-15)
            make.bottom.equalTo(view).offset(-12)
        }
    }
    
    func tapButton_close() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    func tapButton_sendGift() {
        let heartView = PPHeartView()
        heartView.backgroundColor = UIColor.clearColor()
        heartView.frame = CGRectMake(100, 100, 20, 19)
        view .addSubview(heartView)
    }
    func tapButton_comment() {
        
    }
    func tapButton_share() {
        
    }
}
