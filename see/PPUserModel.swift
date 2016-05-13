//
//  PPUserModel.swift
//  weika
//
//  Created by chenpeiwei on 4/5/16.
//  Copyright © 2016 weika.Inc. All rights reserved.
//

import UIKit
import RealmSwift


enum PPUserLoginPlatformType:UInt32 {
    case QQ = 1
    case Wechat = 2
    case Phone = 3
}


class PPUserModel: Object {
    
    static var shareInstance = PPUserModel.generateShareInstance()
    dynamic var ID:String = ""
    dynamic var name:String = ""
    dynamic var genderType:Int = 1
    dynamic var avatarUrl:String = ""
    dynamic var login:Bool = false

    class func getCurrentUser(  completion: ((PPUserModel?)->Void)?) -> Void {
        do {
            let realm = try Realm()
            completion?(realm.objects(PPUserModel).first)
        } catch {
            print("Something went wrong!")
            completion?(nil)
        }
    }
    
    
    class func getCurrentUser()->PPUserModel? {
        let realm = try! Realm()
        return realm.objects(PPUserModel).first
    }
    
    private class func generateShareInstance()->PPUserModel {
        if let user = PPUserModel.getCurrentUser() {
            return user
        } else {
            let realm = try! Realm()
            let user = PPUserModel()
            try! realm.write {
                realm.add(user)
            }
            return user
        }
    }
    class func reGenerateShareInstance() {
        shareInstance = PPUserModel.generateShareInstance()
    }
    

  

    
}


