//
//  PPLoginViewController.swift
//  live
//
//  Created by chenpeiwei on 3/4/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit
import PKHUD
class PPLoginViewController: UIViewController,TLSStrAccountRegListener,TLSOpenQueryListener,TLSOpenLoginListener {

    
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
        button.setTitle("微博登陆", forState: .Normal)
        button.frame = CGRect(origin: CGPointMake(100, 320), size: CGSizeMake(100, 100))
        button.backgroundColor = UIColor.grayColor()
        button.tag = 3
        return button
    }()



    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        view .addSubview(wechatButton)
        view .addSubview(qqButton)
        view .addSubview(weiboButton)

        wechatButton.addTarget(self, action: #selector(PPLoginViewController.getAuthInfo(_:)), forControlEvents: .TouchUpInside)
        weiboButton.addTarget(self, action: #selector(PPLoginViewController.getAuthInfo(_:)), forControlEvents: .TouchUpInside)
        qqButton.addTarget(self, action: #selector(PPLoginViewController.getAuthInfo(_:)), forControlEvents: .TouchUpInside)

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
        case 1: platformType = .WeChat
        case 2: platformType = .QQ
        case 3: platformType = .Weibo
        default : platformType = .Unknown
        }
        
        PPShareManager.sharedInstance.superAuth(platformType, completionHandler: { (finished) in
            if finished {
                self.query()
            }
        })
    }
    
    private func query() {
        let ret = TLSHelper.getInstance().TLSOpenQuery(PPShareInfo.sharedInstance.platformType, andOpenAppid: PPShareInfo.sharedInstance.appid, andOpenId: PPShareInfo.sharedInstance.openID, andAccessToken: PPShareInfo.sharedInstance.accessToken, andListener: self)
        print("query ret \(ret) \(PPShareInfo.sharedInstance.platformType)  \(PPShareInfo.sharedInstance.appid)")

    }
    
    func login() {
         TLSHelper.getInstance().TLSOpenLogin(PPShareInfo.sharedInstance.platformType, andOpenId: PPShareInfo.sharedInstance.openID, andAppid: PPShareInfo.sharedInstance.appid, andAccessToken: PPShareInfo.sharedInstance.accessToken, andTLSOpenLoginListener: self)
    }
    func register() {
        print("register")

        let ret = TLSHelper.getInstance().TLSStrAccountReg(PPShareInfo.sharedInstance.username, andPassword: "sHiJie666", andAccType: PPShareInfo.sharedInstance.platformType, andOpenAppid: PPShareInfo.sharedInstance.appid, andOpenId: PPShareInfo.sharedInstance.openID, andAccessToken: PPShareInfo.sharedInstance.accessToken, andTLSStrAccountRegListener: self)
        print("register ret \(ret)")
    }
    
    
    
    //MARK:注册 回调
    func OnStrAccountRegFail(errInfo: TLSErrInfo!) {
        HUD.flash(.Label("OnStrAccountRegFail \(errInfo)  "),delay:2.0)
    }
    func OnStrAccountRegSuccess(userInfo: TLSUserInfo!) {
        HUD.flash(.Label("OnStrAccountRegSuccess \(userInfo)  "),delay:2.0)
        
    }
    func OnStrAccountRegTimeout(errInfo: TLSErrInfo!) {
        HUD.flash(.Label("OnStrAccountRegTimeout \(errInfo)  "),delay:2.0)
    }
    
    
    //MARK:查询 回调
    func OnOpenQueryFail(errInfo: TLSErrInfo!) {
        HUD.flash(.Label(" OnOpenQueryFail \(errInfo)  "),delay:2.0)
        print("OnOpenQueryFail \(errInfo)")
    }
    
    func OnOpenQuerySuccess(state: TLSOpenState) {
        print("OnOpenQuerySuccess \(state.rawValue)")
        HUD.flash(.Label(" OnOpenQuerySuccess \(state.rawValue)  ") ,delay:3.0)
        
        if  state.rawValue == 3 {
            register()
        } else {
            login()
        }
    }
    
    func OnOpenQueryTimeout(errInfo: TLSErrInfo!) {
        HUD.flash(.Label("OnOpenQueryTimeout \(errInfo)  "),delay:2.0)
    }
    
    
    
    //MARK:登录 回调

    func OnOpenLoginFail(errInfo: TLSErrInfo!) {
        
        HUD.flash(.Label(" OnOpenLoginFail\(errInfo)  "),delay:2.0)
        
    }
    
    func OnOpenLoginTimeout(errInfo: TLSErrInfo!) {
        HUD.flash(.Label(" OnOpenLoginTimeout\(errInfo)  "),delay:2.0)
    }
    
    func OnOpenLoginSuccess(userInfo: TLSUserInfo!) {
        print("OnOpenLoginSuccess\(userInfo)")
        HUD.flash(.Label(" OnOpenLoginSuccess\(userInfo)  "),delay:2.0)
    }
    
}
