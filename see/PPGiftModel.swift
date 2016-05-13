//
//  PPGiftModel.swift
//  vision_demo
//
//  Created by TUPAI-Huangwei on 3/18/16.
//  Copyright © 2016 TUPAI-Huangwei. All rights reserved.
//

import UIKit

class PPGiftModel: NSObject {
    
    var imageName: String
    var diamondCount: Int
    var experienceCount: Int
    
    init(imageName: String, diamondCount: Int, experienceCount:Int, selected: Bool) {
        self.imageName       = imageName
        self.diamondCount    = diamondCount
        self.experienceCount = experienceCount
    }
    
    
}
