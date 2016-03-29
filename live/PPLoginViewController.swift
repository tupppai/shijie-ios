//
//  PPLoginViewController.swift
//  live
//
//  Created by chenpeiwei on 3/4/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPLoginViewController: UIViewController,TLSStrAccountRegListener,TLSOpenQueryListener,TLSOpenLoginListener {

    var mutableInfo:NSMutableDictionary? = NSMutableDictionary()
    
     enum AuthType {
        case WeChat
        case QQ
        case Weibo
    }
    
    lazy var wechatButton: UIButton = {
       var button = UIButton(type: .Custom)
        button.setTitle("微信登陆", forState: .Normal)
        button.frame = CGRect(origin: CGPointMake(100, 100), size: CGSizeMake(100, 100))
        button.backgroundColor = UIColor.grayColor()
        return button
    }()
    
    lazy var weiboButton: UIButton = {
        var button = UIButton(type: .Custom)
        button.setTitle("微博登陆", forState: .Normal)
        button.frame = CGRect(origin: CGPointMake(100, 210), size: CGSizeMake(100, 100))
        button.backgroundColor = UIColor.grayColor()
        return button
    }()

    lazy var qqButton: UIButton = {
        var button = UIButton(type: .Custom)
        button.setTitle("QQ登陆", forState: .Normal)
        button.frame = CGRect(origin: CGPointMake(100, 320), size: CGSizeMake(100, 100))
        button.backgroundColor = UIColor.grayColor()
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        view .addSubview(wechatButton)
//        view .addSubview(qqButton)
//        view .addSubview(weiboButton)

        wechatButton .addTarget(self, action: Selector(getAuthInfo(.WeChat)), forControlEvents: .TouchUpInside)
        weiboButton .addTarget(self, action: Selector(getAuthInfo(.Weibo)), forControlEvents: .TouchUpInside)
        qqButton .addTarget(self, action: Selector(getAuthInfo(.QQ)), forControlEvents: .TouchUpInside)
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
    
    func getAuthInfo(authType:MonkeyKing.SupportedPlatform) {
        
        MonkeyKing.OAuth(authType) {[weak self] (OAuthInfo, response, error) -> Void in
//            self!.query(OAuthInfo)
            print(OAuthInfo)
        }
    }
    
    private func query(OAuthInfo: NSDictionary?) {
        
        mutableInfo = OAuthInfo?.mutableCopy() as? NSMutableDictionary
        
        guard let token = mutableInfo?["access_token"] as? String,
            let openID = mutableInfo?["openid"] as? String
            else {
                return
            }
        
        TLSHelper.getInstance().TLSOpenQuery(2, andOpenAppid: Configs.Wechat.appID, andOpenId: openID, andAccessToken: token, andListener: self)
        
    }
    
    func login() {
        guard let token = mutableInfo?["access_token"] as? String,
            let openID = mutableInfo?["openid"] as? String
//            let refreshToken = mutableInfo?["refresh_token"] as? String,
//            let expiresIn = mutableInfo?["expires_in"] as? Int
            else {
                return
        }
        
        let userInfoAPI = "https://api.weixin.qq.com/sns/userinfo"
        
        let parameters = [
            "openid": openID,
            "access_token": token
        ]
        
        SimpleNetworking.sharedInstance.request(userInfoAPI, method: .GET, parameters: parameters, completionHandler: { (userInfoDictionary, _, _) -> Void in
            
//            guard let userDic = userInfoDictionary?.mutableCopy() as? NSMutableDictionary else {
//                return
//            }
            
//            userDic["access_token"] = token
//            userDic["openid"] = openID
//            userDic["refresh_token"] = refreshToken
//            userDic["expires_in"] = expiresIn
            
            let ret = TLSHelper.getInstance().TLSOpenLogin(2, andOpenId: openID, andAppid: Configs.Wechat.appID, andAccessToken: token, andTLSOpenLoginListener: self)
            print("TLSOpenLogin ret\(ret)")
            
        })

    }
    func register() {
        guard let token = mutableInfo?["access_token"] as? String,
            let openID = mutableInfo?["openid"] as? String
//            let refreshToken = mutableInfo?["refresh_token"] as? String,
//            let expiresIn = mutableInfo?["expires_in"] as? Int
            else {
                return
        }
        
        let userInfoAPI = "https://api.weixin.qq.com/sns/userinfo"
        
        let parameters = [
            "openid": openID,
            "access_token": token
        ]
        
        SimpleNetworking.sharedInstance.request(userInfoAPI, method: .GET, parameters: parameters, completionHandler: { (userInfoDictionary, _, _) -> Void in
            
            guard let userDic = userInfoDictionary?.mutableCopy() as? NSMutableDictionary else {
                return
            }
//            
//            userDic["access_token"] = token
//            userDic["openid"] = openID
//            userDic["refresh_token"] = refreshToken
//            userDic["expires_in"] = expiresIn
            
            TLSHelper.getInstance().TLSStrAccountReg(userDic["nickname"] as? String, andPassword: "sHiJie666", andAccType: 2, andOpenAppid: Configs.Wechat.appID, andOpenId: openID, andAccessToken: token, andTLSStrAccountRegListener: self)
        })

    }
    
    
    
    //MARK:注册 回调
    func OnStrAccountRegFail(errInfo: TLSErrInfo!) {
        print("OnStrAccountRegFail \(errInfo)")
    }
    func OnStrAccountRegSuccess(userInfo: TLSUserInfo!) {
        print("OnStrAccountRegSuccess \(userInfo)")
        
    }
    func OnStrAccountRegTimeout(errInfo: TLSErrInfo!) {
        print("OnStrAccountRegTimeout \(errInfo)")

    }
    
    
    //MARK:查询 回调
    func OnOpenQueryFail(errInfo: TLSErrInfo!) {
        print("OnOpenQueryFail\(errInfo)")
    }
    
    func OnOpenQuerySuccess(state: TLSOpenState) {
        print("OnOpenQuerySuccess\(state)")
        if  state.rawValue == 3 {
            register()
        } else {
            login()
        }
    }
    
    func OnOpenQueryTimeout(errInfo: TLSErrInfo!) {
        print("OnOpenQueryTimeout\(errInfo)")
    }
    
    
    
    //MARK:登录 回调

    func OnOpenLoginFail(errInfo: TLSErrInfo!) {
        print("OnOpenLoginFail\(errInfo)")
    }
    
    func OnOpenLoginTimeout(errInfo: TLSErrInfo!) {
        print("OnOpenLoginTimeout\(errInfo)")

    }
    
    func OnOpenLoginSuccess(userInfo: TLSUserInfo!) {
        print("OnOpenLoginTimeout\(userInfo)")

    }
    
}
