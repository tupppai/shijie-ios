//
//  PPLiveCommentModel.swift
//  see
//
//  Created by chenpeiwei on 5/18/16.
//  Copyright © 2016 pires.inc. All rights reserved.
//

import UIKit

class PPLiveCommentModel: NSObject {
    var content:String!
    var senderId:String?
    var senderName:String?
//    var comment:String!
    override init() {
        content = ""
        senderId = ""
        senderName = ""
//        comment = ""
    }
}
