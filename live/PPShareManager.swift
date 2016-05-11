//
//  PPShareManager.swift
//  live
//
//  Created by chenpeiwei on 3/23/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import Foundation

struct ShareConfigs {
    
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
    case Wechat = 2
    case Weibo = 3
    
}

enum PPOpenPlatformURL:String {
    case QQ = "https://graph.qq.com/user/get_user_info"
    case Weibo = "https://api.weibo.com/2/users/show.json"
    case WeChat = "https://api.weixin.qq.com/sns/userinfo"
}

public enum PPOpenPlatformSubtype {
    case QQFriend
    case QZone
    
    case WeChatFriend
    case WeChatMoments
    case Weibo
}


class PPShareManager:NSObject {
    
    static let sharedInstance = PPShareManager()
    
    func shareToPlatform(subtype:PPOpenPlatformSubtype) {
        switch(subtype) {
        case .Weibo:
            //sina
            if !MonkeyKing.isAppInstalled(.Weibo) {
                print("没有安装微博")
                return
            }
            let message = MonkeyKing.Message.Weibo(.Default(info: (
                title: "News",
                description: "Hello Yep",
                thumbnail: UIImage(named: "rabbit"),
                media: .URL(NSURL(string: "http://soyep.com")!)
                ), accessToken: nil))
            MonkeyKing.shareMessage(message) { result in
                print("result: \(result)")
            }
            
        case .WeChatMoments:
            //wechat moments
            if !MonkeyKing.isAppInstalled(.WeChat) {
                print("没有安装微信")
                return
            }
            
            let message = MonkeyKing.Message.WeChat(.Timeline(info: (
                title: "Session",
                description: "Hello Session",
                thumbnail: UIImage(named: "rabbit"),
                media: .URL(NSURL(string: "http://www.apple.com/cn")!)
            )))
            
            MonkeyKing.shareMessage(message) { success in
                print("shareURLToWeChatSession success: \(success)")
            }
        case .WeChatFriend:
            //wechat session
            if !MonkeyKing.isAppInstalled(.WeChat) {
                print("没有安装微信")
                return
            }
            let message = MonkeyKing.Message.WeChat(.Session(info: (
                title: "Session",
                description: "Hello Session",
                thumbnail: UIImage(named: "demo"),
                media: .URL(NSURL(string: "http://www.apple.com/cn")!)
            )))
            
            MonkeyKing.shareMessage(message) { success in
                print("shareURLToWeChatSession success: \(success)")
            }
            
        case .QQFriend:
            //QQ
            if !MonkeyKing.isAppInstalled(.QQ) {
                print("没有安装QQ")
                return
            }
            let info = MonkeyKing.Info(
                title: "QQ URL, \(NSUUID().UUIDString)",
                description: "apple.com/cn, \(NSUUID().UUIDString)",
                thumbnail: UIImage(named: "demo"),
                media: .URL(NSURL(string: "http://www.apple.com/cn")!)
            )
            let message :MonkeyKing.Message? = MonkeyKing.Message.QQ(.Friends(info: info))
            
            if let message = message{
                MonkeyKing.shareMessage(message) { result in
                    print("result: \(result)")
                }
            }
            
        case .QZone:
            //QZone
            if !MonkeyKing.isAppInstalled(.QQ) {
                print("没有安装QQ")
                return
            }
            let info = MonkeyKing.Info(
                title: "QQ URL, \(NSUUID().UUIDString)",
                description: "apple.com/cn, \(NSUUID().UUIDString)",
                thumbnail: UIImage(named: "demo"),
                media: .URL(NSURL(string: "http://www.apple.com/cn")!)
            )
            let message :MonkeyKing.Message? = MonkeyKing.Message.QQ(.Zone(info: info))
            
            if let message = message{
                MonkeyKing.shareMessage(message) { result in
                    print("result: \(result)")
                }
            }
            
        }
    }
    
    
    
    func superAuth(platformType:PPOpenPlatformType , completionHandler:((Bool)->Void)? ) {
        
        var MonkeyKingPlatform:MonkeyKing.SupportedPlatform
        var scope:String? = nil
        
        switch platformType {
        case .QQ:
            MonkeyKingPlatform = MonkeyKing.SupportedPlatform.QQ
            scope = "get_user_info"
        case .Wechat:
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
                    "oauth_consumer_key": ShareConfigs.QQ.appID
                ]
                URL = PPOpenPlatformURL.QQ.rawValue
            case .Wechat:
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
                appid = ShareConfigs.QQ.appID
            case PPOpenPlatformType.Wechat.rawValue:
                appid = ShareConfigs.Wechat.appID
            case PPOpenPlatformType.Weibo.rawValue:
                appid = ShareConfigs.Weibo.appID
            default:break
            }
            PPShareInfo.sharedInstance.appid = appid
            
            
            SimpleNetworking.sharedInstance.request(URL, method: .GET, parameters: parameters, completionHandler: { (userInfoDictionary, _, error) -> Void in
                
                PPShareInfo.sharedInstance.rawData = userInfoDictionary
                switch platformType {
                case .QQ:
                    
                    guard let userAvatarURL = userInfoDictionary?["figureurl_2"] as? String,
                        let username = userInfoDictionary?["nickname"] as? String,
                        let sex = userInfoDictionary?["gender"] as? String
                        else {
                            if let completionHandler = completionHandler {
                                completionHandler(false)
                            }
                            return
                    }
                    
                    PPShareInfo.sharedInstance.userAvatarURL = userAvatarURL
                    PPShareInfo.sharedInstance.username = username
                    if sex == "男" {
                        PPShareInfo.sharedInstance.gender = .Male
                    } else if sex == "女" {
                        PPShareInfo.sharedInstance.gender = .Female
                    } else {
                        PPShareInfo.sharedInstance.gender = .Unknown
                    }
                    
                case .Wechat:
                    
                    guard let userAvatarURL = userInfoDictionary?["headimgurl"] as? String,
                        let username = userInfoDictionary?["nickname"] as? String,
                        let sex = userInfoDictionary?["sex"] as? Int
                        else {
                            if let completionHandler = completionHandler {
                                completionHandler(false)
                            }
                            return
                    }
                    
                    PPShareInfo.sharedInstance.userAvatarURL = userAvatarURL
                    PPShareInfo.sharedInstance.username = username
                    if sex == 1 {
                        PPShareInfo.sharedInstance.gender = .Male
                    } else if sex == 2 {
                        PPShareInfo.sharedInstance.gender = .Female
                    } else {
                        PPShareInfo.sharedInstance.gender = .Unknown
                    }
                    
                case .Weibo:
                    
                    guard let userAvatarURL = userInfoDictionary?["avatar_large"] as? String,
                        let username = userInfoDictionary?["screen_name"] as? String,
                        let sex = userInfoDictionary?["gender"] as? String
                        else {
                            if let completionHandler = completionHandler {
                                completionHandler(false)
                            }
                            return
                    }
                    PPShareInfo.sharedInstance.userAvatarURL = userAvatarURL
                    PPShareInfo.sharedInstance.username = username
                    if sex == "m" {
                        PPShareInfo.sharedInstance.gender = .Male
                    } else if sex == "f" {
                        PPShareInfo.sharedInstance.gender = .Female
                    } else {
                        PPShareInfo.sharedInstance.gender = .Unknown
                    }
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