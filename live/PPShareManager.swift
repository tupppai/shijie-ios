//
//  PPShareManager.swift
//  live
//
//  Created by chenpeiwei on 3/23/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import Foundation

enum PPOpenPlatformType:UInt32 {
    case Unknown = 0
    case QQ = 1
    case WeChat = 2
    case Weibo = 3
    
}

enum PPOpenPlatformURL:String {
    case QQ = "https://graph.qq.com/user/get_user_info"
    case Weibo = "https://api.weibo.com/2/users/show.json"
    case WeChat = "https://api.weixin.qq.com/sns/userinfo"
}


class PPShareManager:NSObject {
    
    
    static let sharedInstance = PPShareManager()

    func superAuth(platformType:PPOpenPlatformType , completionHandler:((Bool)->Void)? ) {
        
        var MonkeyKingPlatform:MonkeyKing.SupportedPlatform
        var scope:String? = nil

        switch platformType {
        case .QQ:
            MonkeyKingPlatform = MonkeyKing.SupportedPlatform.QQ
            scope = "get_user_info"
        case .WeChat:
            MonkeyKingPlatform = MonkeyKing.SupportedPlatform.WeChat
        case .Weibo:
            MonkeyKingPlatform = MonkeyKing.SupportedPlatform.Weibo
        default :
            if let completionHandler = completionHandler {
                completionHandler(false)
            }
            return
        }
        
        
        MonkeyKing.OAuth(MonkeyKingPlatform ,scope: scope) { (OAuthInfo, response, error) -> Void in
            
            var accessToken:String!
            var openID : String!
            var parameters: [String:AnyObject]!
            var URL:String!
            
            switch platformType {
            case .QQ:
                guard let token = OAuthInfo?["access_token"] as? String,
                    ID = OAuthInfo?["openid"] as? String else {
                        if let completionHandler = completionHandler {
                            completionHandler(false)
                        }
                        return
                }
                accessToken = token
                openID = ID
                parameters = [
                    "openid": ID,
                    "access_token": token,
                    "oauth_consumer_key": Configs.QQ.appID
                ]
                URL = PPOpenPlatformURL.QQ.rawValue
            case .WeChat:
                guard let token = OAuthInfo?["access_token"] as? String,
                    ID = OAuthInfo?["openid"] as? String else {
                        if let completionHandler = completionHandler {
                            completionHandler(false)
                        }
                        return
                }
                accessToken = token
                openID = ID
                parameters = [
                    "openid": ID,
                    "access_token": token,
                ]
                URL = PPOpenPlatformURL.WeChat.rawValue

            case .Weibo:
                guard let token = OAuthInfo?["accessToken"] as? String,
                    ID = (OAuthInfo?["uid"] ?? OAuthInfo?["userID"]) as? String else {
                        if let completionHandler = completionHandler {
                            completionHandler(false)
                        }
                        return
                }
                accessToken = token
                openID = ID
                parameters = [
                    "uid": ID,
                    "access_token": token,
                ]
                URL = PPOpenPlatformURL.Weibo.rawValue
            default:
                if let completionHandler = completionHandler {
                    completionHandler(false)
                }
                return
            }
            
            PPShareInfo.sharedInstance.openID = openID
            PPShareInfo.sharedInstance.accessToken = accessToken
            PPShareInfo.sharedInstance.platformType = platformType

            SimpleNetworking.sharedInstance.request(URL, method: .GET, parameters: parameters, completionHandler: { (userInfoDictionary, _, error) -> Void in
                switch platformType {
                    case .QQ:
                        
                    guard let userAvatarURL = userInfoDictionary?["figureurl_2"] as? String,
                        let username = userInfoDictionary?["nickname"] as? String
                        else {
                            if let completionHandler = completionHandler {
                                completionHandler(false)
                            }
                            return
                        }
                    PPShareInfo.sharedInstance.userAvatarURL = userAvatarURL
                    PPShareInfo.sharedInstance.username = username

                    case .WeChat:
                    
                        guard let userAvatarURL = userInfoDictionary?["headimgurl"] as? String,
                            let username = userInfoDictionary?["nickname"] as? String
                            else {
                                if let completionHandler = completionHandler {
                                    completionHandler(false)
                                }
                                return
                        }
                        PPShareInfo.sharedInstance.userAvatarURL = userAvatarURL
                        PPShareInfo.sharedInstance.username = username

                    
                    case .Weibo:
                        
                        guard let userAvatarURL = userInfoDictionary?["avatar_large"] as? String,
                            let username = userInfoDictionary?["screen_name"] as? String
                            else {
                                if let completionHandler = completionHandler {
                                    completionHandler(false)
                                }
                                return
                        }
                        PPShareInfo.sharedInstance.userAvatarURL = userAvatarURL
                        PPShareInfo.sharedInstance.username = username
                    
                default :
                    if let completionHandler = completionHandler {
                        completionHandler(false)
                    }
                    return
                }
                
                if let completionHandler = completionHandler {
                    completionHandler(true)
                }
                
            })
        }
    }


}