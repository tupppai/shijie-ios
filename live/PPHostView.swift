//
//  PPHostView.swift
//  live
//
//  Created by chenpeiwei on 3/18/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPHostView: UIView {
    
    var avatarButton:UIButton!
    var assistLabel:UILabel!
    var audienceCountLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex: 0x000000, alpha: 0.5)
        
        avatarButton = UIButton(type: .Custom)
        
        assistLabel = UILabel()
        assistLabel.text = "直播live"
        assistLabel.font = UIFont.systemFontOfSize(13)
        assistLabel.textColor = UIColor.whiteColor()
        
        audienceCountLabel = UILabel()
        audienceCountLabel.font = UIFont.systemFontOfSize(13)
        audienceCountLabel.textColor = UIColor.whiteColor()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

