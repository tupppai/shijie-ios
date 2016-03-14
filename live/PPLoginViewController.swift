//
//  PPLoginViewController.swift
//  live
//
//  Created by chenpeiwei on 3/4/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPLoginViewController: UIViewController {

    lazy var wechatButton: UIButton = {
       var button = UIButton(type: .Custom)
        button.setTitle("微信登陆", forState: .Normal)
        button.frame = CGRect(origin: CGPointMake(100, 100), size: CGSizeMake(100, 100))
        button.backgroundColor = UIColor.grayColor()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view .addSubview(wechatButton)
        view.backgroundColor = UIColor.whiteColor()
        wechatButton .addTarget(self, action: "OAuthWechat", forControlEvents: .TouchUpInside);
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
    
    func OAuthWechat() {
        MonkeyKing.OAuth(MonkeyKing.SupportedPlatform.WeChat) {[weak self] (OAuthInfo, response, error) -> Void in
            self!.fetchUserInfo(OAuthInfo)
        }
    }
    
    private func fetchUserInfo(OAuthInfo: NSDictionary?) {
        
        guard let token = OAuthInfo?["access_token"] as? String,
            let openID = OAuthInfo?["openid"] as? String,
            let refreshToken = OAuthInfo?["refresh_token"] as? String,
            let expiresIn = OAuthInfo?["expires_in"] as? Int else {
                return
        }
        
        let userInfoAPI = "https://api.weixin.qq.com/sns/userinfo"
        
        let parameters = [
            "openid": openID,
            "access_token": token
        ]
        
        // fetch UserInfo by userInfoAPI
        SimpleNetworking.sharedInstance.request(userInfoAPI, method: .GET, parameters: parameters, completionHandler: { (userInfoDictionary, _, _) -> Void in
            
            guard let mutableDictionary = userInfoDictionary?.mutableCopy() as? NSMutableDictionary else {
                return
            }
            
            mutableDictionary["access_token"] = token
            mutableDictionary["openid"] = openID
            mutableDictionary["refresh_token"] = refreshToken
            mutableDictionary["expires_in"] = expiresIn
            
            print("userInfoDictionary \(mutableDictionary)")
        })
        
        // More API
        // http://mp.weixin.qq.com/wiki/home/index.html
    }


}
