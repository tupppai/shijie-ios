//
//  PPUserModel_toremove.swift
//  live
//
//  Created by TUPAI-Huangwei on 3/23/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPUserModel_toremove: NSObject {
    var avatarImageUrl: String
    var username: String
    var coinsContributed: Int
    var ranking: Int
    
    init(avatarImageUrl: String, username: String, coinsContributed: Int, ranking: Int){
        self.avatarImageUrl   = avatarImageUrl
        self.username         = username
        self.coinsContributed = coinsContributed
        self.ranking          = ranking
    }
    
}
