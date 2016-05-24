//
//  PPNetworkManager.swift
//  weika
//
//  Created by chenpeiwei on 4/5/16.
//  Copyright © 2016 weika.Inc. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD

struct NetworkConfigs {
    static let baseURL         = "http://api.chupinlm.com/t/"
}
enum PPNetworkResponseCode:Int {
    case Success = 0
    case NotLogin = 1003
    case ServerIsWrong = 1009
}

//Mob 短信验证返回码
enum PPVerifyResponseCode:Int {
    case Success = 0
    case AppkeyIsNil = 405
    case AppkeyIsInvalid = 406
    case CountryCodeOrPhoneIsNil = 456
    case PhoneFormatIsWrong = 457
    case VerifyCodeIsNil = 466
    case VerifyTooFrequent = 467
    case VerifyCodeIsWrong = 468
    case VerifyServerIsNotOpen = 474
}

public class PPNetworkManager: Manager {
    
    //should named something except from sharedInstance In Manager
    static public let manager = PPNetworkManager.generateManager()
    class func generateManager()->PPNetworkManager {
//        var defaultHeaders = Alamofire.Manager.defaultHTTPHeaders ?? [:]
//        defaultHeaders["Content-Type"] = "application/x-www-form-urlencoded"

        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
//        configuration.HTTPAdditionalHeaders = defaultHeaders
        let manager = PPNetworkManager(configuration: configuration)
        return manager
    }
    
    //Jason told me all request are POST ,So...
    class func postRequest(_relativeURLString: URLStringConvertible, parameters: [String : AnyObject]?) -> Request {
        let URLString = NetworkConfigs.baseURL + _relativeURLString.URLString
        return manager.request(.POST, URLString, parameters: parameters, encoding: .JSON, headers: nil)
    }
    

    //override is better than OC's method swizzle
    public override func request(method: Alamofire.Method, _ URLString: URLStringConvertible, parameters: [String : AnyObject]?, encoding: ParameterEncoding, headers: [String : String]?) -> Request {
        
        return super.request(method, URLString, parameters: parameters, encoding: encoding, headers: headers).responseJSON
            { response in
                debugPrint(response.request)
                debugPrint(response)

                switch response.result {
                case .Success(let JSON):
                    let response = JSON as! NSDictionary
                    if let errCode = response.objectForKey("errCode") as? Int,errMsg = response.objectForKey("errMsg")as? String {
                        if errCode == PPNetworkResponseCode.NotLogin.rawValue {
                            //login
//                            PPShowLoginAlertViewController()
                            //1.clear database and other logic 2.Show login
                            
                        } else {
                            let info =  "\(errCode),\(errMsg)"
                            HUD.flash(.Label(info),delay: 1.5)
                        }
                    }
                case .Failure:
                    if !HUD.isVisible {
                        HUD.flash(.Label("服务请求失败😭"),delay: 1.5)
                    }
            }
        }
    }
    
    func clearCookies() {
        let cookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        if let cookies = cookieStorage.cookies {
            for cookie in cookies {
                cookieStorage.deleteCookie(cookie)
            }
        }
    }
    
}



/**
 ** 连接融云服务器，如果失败，尝试retryTimes次重连
**/

public func PPConnectRCIM(retryTimes:Int) {
    print("PPConnectRCIM left retryTimes \(retryTimes)")
    PPNetworkManager.postRequest("im/get-token", parameters: nil).responseJSON { (response) in
        switch response.result {
        case .Success(let JSON):
            if let errCode = JSON.objectForKey("errCode") as? Int {
                if errCode != 0 {
                    return
                }
            }
            
            guard let data = JSON.objectForKey("data") as? NSDictionary else{
                return
            }
            
            guard let token = data.objectForKey("token") as? String else{
                return
            }
            
            //连接融云服务器
            RCIM.sharedRCIM().connectWithToken(token,
                success: { (userId) -> Void in
                    print("登陆成功。当前登录的用户ID：\(userId)")
                    //设置当前登陆用户的信息
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        let name = PPUserModel.shareInstance.name
                        let avatarUrl = PPUserModel.shareInstance.avatarUrl
                        RCIM.sharedRCIM().currentUserInfo = RCUserInfo.init(userId: userId, name: name, portrait: avatarUrl)
                    })
                    
                }, error: { (status) -> Void in
                    print("登陆的错误码为:\(status.rawValue)")
                }, tokenIncorrect: {
                    //token过期或者不正确。
                    //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                    //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                    
                    //recursive!
                    if retryTimes > 0 {
                        PPConnectRCIM(retryTimes-1)
                    }
                    
                    print("token错误")
            })
            
            
        default:
            break
            
        }
        
    }
}


public func PPCloseMyAbandonedLiveRoom() {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    guard let streamIDString = defaults.objectForKey("StreamIDStringKey") else{
        return
    }
   
    PPNetworkManager.postRequest("stream/finish", parameters: ["streamId":streamIDString]).responseJSON { (response) in
        switch response.result {
        case .Success(let json):
            let JSON = json as? NSDictionary
            if let errorCode = JSON?.objectForKey("errCode") as? Int  {
                if errorCode != 0 {
                    print("服务器还没接到关闭通知error")
                } else {
                    print("服务器成功接到关闭通知ok")
                    defaults.setObject(nil, forKey: "StreamIDStringKey")
                }
            }
        case .Failure:
            break
        }
    }
}


