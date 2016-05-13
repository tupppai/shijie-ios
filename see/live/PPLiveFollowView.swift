//
//  PPLiveFollowView.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/10.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPLiveFollowView: UIView {
    private var avatarImageView: PPRoundImageView!
    private var usernameLabel: UILabel!
    private var followButton: UIButton!
    private var followDescLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    convenience init(){
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
        setupConstraints()
    }
    
    // UI setup
    private func setupSubviews(){
        self.backgroundColor = UIColor.whiteColor()
        
        // 头像
        avatarImageView = PPRoundImageView(image: UIImage(named: "avatar_example_2"))
        avatarImageView.layer.borderColor = UIColor(hex: 0xFF5722).CGColor
        avatarImageView.layer.borderWidth = 2
        self.addSubview(avatarImageView)
        
        // 用户名
        usernameLabel               = UILabel()
        usernameLabel.text          = "虐猫狂人"
        usernameLabel.textColor     = UIColor(hex: 0xFF5752)
        usernameLabel.font          = UIFont.systemFontOfSize(17)
        usernameLabel.textAlignment = .Center
        self.addSubview(usernameLabel)
        
        // 关注按钮
        followButton = UIButton()
        followButton.setImage(UIImage(named: "followButton_shadow"), forState: .Normal)
        self.addSubview(followButton)
        
        // 更多信息
        followDescLabel               = UILabel()
        followDescLabel.text          = "关注Ta，下一次直播就会有通知哦"
        followDescLabel.font          = UIFont.systemFontOfSize(10)
        followDescLabel.textAlignment = .Center
        followDescLabel.textColor     = UIColor(hex: 0x525877)
        self.addSubview(followDescLabel)
    }
    
    private func setupConstraints(){
        avatarImageView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 100,height: 100))
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(18)
        }
        
        usernameLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(avatarImageView.snp_bottom).offset(15)
        }
        
        followButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(usernameLabel.snp_bottom).offset(43)
        }
        
        followDescLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(followButton.snp_bottom).offset(10)
        }
    }
}
