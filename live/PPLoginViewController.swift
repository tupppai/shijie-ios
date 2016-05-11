//
//  PPLoginViewController.swift
//  live
//
//  Created by chenpeiwei on 3/4/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit
import PKHUD
import Alamofire
class PPLoginViewController: UIViewController {

    
    enum AuthType:UInt32 {
        case WeChat = 2
        case QQ = 1
        case Weibo = 3
    }
    
    lazy var wechatButton: UIButton = {
       var button = UIButton(type: .Custom)
        button.setTitle("微信登陆", forState: .Normal)
        button.tag = 1
        button.frame = CGRect(origin: CGPointMake(100, 100), size: CGSizeMake(100, 100))
        button.backgroundColor = UIColor.grayColor()
        return button
    }()
    
    lazy var qqButton: UIButton = {
        var button = UIButton(type: .Custom)
        button.tag = 2
        button.setTitle("QQ登陆", forState: .Normal)
        button.frame = CGRect(origin: CGPointMake(100, 210), size: CGSizeMake(100, 100))
        button.backgroundColor = UIColor.grayColor()
        return button
    }()
    
    lazy var weiboButton: UIButton = {
        var button = UIButton(type: .Custom)
        button.setTitle("微博登录", forState: .Normal)
        button.frame = CGRect(origin: CGPointMake(100, 320), size: CGSizeMake(100, 100))
        button.backgroundColor = UIColor.grayColor()
        button.tag = 3
        return button
    }()

    lazy var closeButton: UIButton = {
        var button = UIButton(type: .Custom)
        button.setTitle("X", forState: .Normal)
        button.frame = CGRect(origin: CGPointMake(220, 200), size: CGSizeMake(50, 50))
        button.backgroundColor = UIColor.grayColor()
        button.tag = 4
        return button
    }()

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        view .addSubview(wechatButton)
        view .addSubview(qqButton)
        view .addSubview(weiboButton)
        view .addSubview(closeButton)

        wechatButton.addTarget(self, action: #selector(PPLoginViewController.getAuthInfo(_:)), forControlEvents: .TouchUpInside)
        qqButton.addTarget(self, action: #selector(PPLoginViewController.getAuthInfo(_:)), forControlEvents: .TouchUpInside)
        weiboButton.addTarget(self, action: #selector(PPLoginViewController.getAuthInfo(_:)), forControlEvents: .TouchUpInside)
        closeButton.addTarget(self, action: #selector(PPLoginViewController.dismiss), forControlEvents: .TouchUpInside)

    }
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func shareURL(sender: UIButton) {
        let info =  MonkeyKing.Info(
            title: "Timeline URL, \(NSUUID().UUIDString)",
            description: "Description URL, \(NSUUID().UUIDString)",
            thumbnail: UIImage(named: "rabbit"),
            media: .URL(NSURL(string: "http://soyep.com")!)
        )
        self.shareInfo(info)
    }
    
    func testCookies() {
        Manager.sharedInstance.request(.POST, "http://api.chupinlm.com/user/my-info", parameters: nil, encoding: .JSON, headers: nil).responseJSON(completionHandler: { (response) in
            print("response  \(response)")
        })

    }
    private func shareInfo(info: MonkeyKing.Info) {
        var message :MonkeyKing.Message?
        message = MonkeyKing.Message.WeChat(.Session(info: info))
        if let message = message{
            MonkeyKing.shareMessage(message) { result in
                print("result: \(result)")
            }
        }
    }
    
    func getAuthInfo(sender:AnyObject) {
        
        let tag = sender.tag
        var platformType:PPOpenPlatformType = .Unknown
        
        switch tag {
        case 1: platformType = .Wechat
        case 2: platformType = .QQ
        case 3: platformType = .Weibo
        default : platformType = .Unknown
        }
        
        PPShareManager.sharedInstance.superAuth(platformType, completionHandler: { (finished) in
            if finished {
                
                let param = PPShareInfo.sharedInstance.rawData as? [String:AnyObject]
                Manager.sharedInstance.request(.POST, "http://api.chupinlm.com/user/wechat-login", parameters: param, encoding: .JSON, headers: nil).responseJSON(completionHandler: { (response) in
                    print("response  \(response)")
                })

            }
        })
    }
    

    
}
