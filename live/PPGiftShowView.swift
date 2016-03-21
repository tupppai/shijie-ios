//
//  PPGiftShowView.swift
//  live
//
//  Created by chenpeiwei on 3/20/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPGiftShowView: SpringView {
    var avatarImageView:PPRoundImageView!
    var usernameLabel:UILabel!
    var contentLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex: 0x000000, alpha: 0.8)
        self.layer.cornerRadius = 22
        self.clipsToBounds = true
        setupViews()
        
        
    }
    
    func setupViews() {
        avatarImageView = PPRoundImageView()
        usernameLabel = UILabel()
        usernameLabel.textColor = UIColor.whiteColor()
        usernameLabel.font = UIFont.systemFontOfSize(13)
        
        contentLabel = UILabel()
        contentLabel.textColor = UIColor.whiteColor()
        contentLabel.font = UIFont.systemFontOfSize(13)
        
        self.addSubview(avatarImageView)
        self.addSubview(usernameLabel)
        self.addSubview(contentLabel)
        
        
        avatarImageView.image = UIImage(named: "demoavatar.jpg")
        usernameLabel.text = "peiwei❤️handsome~wow"
        contentLabel.text = "meme送了一辆法拉利🚗"
        
        render()
    }
    
    func render() {
        avatarImageView.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(35)
            make.leading.equalTo(self).offset(4)
            make.centerY.equalTo(self)
        }
        usernameLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(avatarImageView)
            make.leading.equalTo(avatarImageView.snp_trailing)
            make.trailing.equalTo(self)
        }
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(usernameLabel)
            make.bottom.equalTo(avatarImageView)
            make.trailing.equalTo(self)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
