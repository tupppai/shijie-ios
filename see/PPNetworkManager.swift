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
                        } else {
                            let info =  "\(errCode),\(errMsg)"
                            HUD.flash(.Label(info),delay: 1.5)
                        }
                    }
                case .Failure:
                    if !HUD.isVisible {
                        HUD.flash(.Label("您的网络有问题😭˚˚"),delay: 1.5)
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

