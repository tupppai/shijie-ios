//
//  PPLiveModel.swift
//  see
//
//  Created by chenpeiwei on 5/13/16.
//  Copyright © 2016 pires.inc. All rights reserved.
//

import UIKit
import RealmSwift

class PPLiveModel: Object {
    dynamic var ID = 0
    dynamic var title:String = ""
    dynamic var playURL:String = ""
    dynamic var showImageUrl:String = ""
    dynamic var timeIntervalSince1970 = 0
    dynamic var topics = ""
    dynamic var audienceCount = 0
    dynamic var watchedCount = 0
    dynamic var coins = 0
    dynamic var userModel:PPUserModel?
    
    override static func primaryKey() -> String? {
        return "ID"
    }
    
}

