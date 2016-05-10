//
//  PPShareInfo.swift
//  live
//
//  Created by chenpeiwei on 3/30/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//


enum PPGenderType:UInt {
    case Male = 1
    case Female = 2
    case Unknown = 666
}

class PPShareInfo: NSObject {
    static let sharedInstance = PPShareInfo()
    
    var openID:String!
    var appid:String!
    var gender:PPGenderType!
    var accessToken:String!
    var username:String!
    var userAvatarURL:String!
    var platformType:PPOpenPlatformType.RawValue!
    
    var rawData:NSDictionary?
}
