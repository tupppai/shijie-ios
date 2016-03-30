//
//  PPShareManager.swift
//  live
//
//  Created by chenpeiwei on 3/23/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import Foundation

struct Configs {
    
    struct Weibo {
        static let appID = "882276088"
        static let appKey = "454f67c8e6d29b770d701e9272bc5ee7"
        static let redirectURL = "https://api.weibo.com/oauth2/default.html"
    }
    
    struct Wechat {
        static let appID = "wx4868b35061f87885"
        static let appKey = "64020361b8ec4c99936c0e3999a9f249"
    }
    
    struct QQ {
        static let appID = "1104881792"
    }
    
    struct Pocket {
        static let appID = "48363-344532f670a052acff492a25"
        static let redirectURL = "pocketapp48363:authorizationFinished" // pocketapp + $prefix + :authorizationFinished
    }
    
    struct Alipay {
        static let appID = "2016012101112529"
    }
}

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
            PPShareInfo.sharedInstance.platformType = platformType.rawValue

            var appid:String! = ""
            switch PPShareInfo.sharedInstance.platformType {
            case PPOpenPlatformType.QQ.rawValue:
                appid = Configs.QQ.appID
            case PPOpenPlatformType.WeChat.rawValue:
                appid = Configs.Wechat.appID
            case PPOpenPlatformType.Weibo.rawValue:
                appid = Configs.Weibo.appID
            default:break
            }
            PPShareInfo.sharedInstance.appid = appid

            
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