//
//  PPHostView.swift
//  live
//
//  Created by chenpeiwei on 3/18/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPHostView: UIView {
    
    var avatarButton:PPRoundButton!
    var assistLabel:UILabel!
    var audienceCountLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex: 0x000000, alpha: 0.5)
        
        self.layer.cornerRadius = 22
        self.clipsToBounds = true
        
        
        avatarButton = PPRoundButton(type: .Custom)
//        avatarButton.setBackgroundImage(UIImage(named: "demoavatar.jpg"), forState: .Normal)
        avatarButton.setImage(UIImage(named: "demoavatar.jpg"), forState: .Normal)
        avatarButton.sd_setImageWithURL(NSURL(string: PPUserModel.shareInstance.avatarUrl), forState: .Normal)
        avatarButton.backgroundColor = UIColor.greenColor()
        
        assistLabel = UILabel()
        assistLabel.text = "直播live"
        assistLabel.font = UIFont.systemFontOfSize(13)
        assistLabel.textColor = UIColor.whiteColor()
        
        audienceCountLabel = UILabel()
        audienceCountLabel.font = UIFont.systemFontOfSize(13)
        audienceCountLabel.textColor = UIColor.whiteColor()
        audienceCountLabel.text = "1888"
        
        self .addSubview(avatarButton)
        self .addSubview(assistLabel)
        self .addSubview(audienceCountLabel)

        avatarButton.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(self).offset(3)
            make.top.equalTo(self).offset(3)
            make.bottom.equalTo(self).offset(-3)
            make.width.equalTo(avatarButton.snp_height).priorityHigh()
        }
        assistLabel.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(avatarButton.snp_centerY)
            make.leading.equalTo(avatarButton.snp_trailing).offset(5)
        }
        audienceCountLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(assistLabel.snp_bottom).offset(3)
            make.centerX.equalTo(assistLabel.snp_centerX)
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

