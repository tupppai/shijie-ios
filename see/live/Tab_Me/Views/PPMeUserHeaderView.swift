//
//  PPMeUserHeaderView.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/12.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPMeUserHeaderView: UIView {
    
    private var avatarImageView: PPRoundImageView!
    
    private var usernameLabel: UILabel!
    
    private var userDescLabel: UILabel!
    
    private var editUserDescButton: UIButton!
    
    private var privateMessageButton: UIButton!
    
    private var rollRankListView: PPRollContributionListView!
    
    private var buttonsContainerView: UIView!
    
    private var broadcastButton: CountButton!
    
    private var momentsButton: CountButton!
    
    private var followingButton: CountButton!
    
    private var fansButton: CountButton!
    
    private var headerSeparatorView: UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
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
    
    // MARK: UI setup
    private func setupSubviews(){
        // 头像
        avatarImageView = PPRoundImageView(image: UIImage(named: "avatar_example"))
        avatarImageView.layer.borderColor = UIColor(hex: 0xECECEC).CGColor
        avatarImageView.layer.borderWidth = 2
        self.addSubview(avatarImageView)
        
        // 用户名
        usernameLabel               = UILabel()
        usernameLabel.text          = "咩咩mie"
        usernameLabel.textColor     = UIColor.blackColor()
        usernameLabel.textAlignment = .Center
        usernameLabel.font          = UIFont.systemFontOfSize(16)
        self.addSubview(usernameLabel)
        
        // 用户个人描述
        userDescLabel               = UILabel()
        userDescLabel.text          = "亲，填写自己的个人简介更容易吸粉哦"
        userDescLabel.textColor     = UIColor(hex: 0x000000, alpha: 0.5)
        userDescLabel.textAlignment = .Center
        userDescLabel.font          = UIFont.systemFontOfSize(12)
        self.addSubview(userDescLabel)
        
        editUserDescButton = UIButton()
        editUserDescButton.setImage(UIImage(named: "btn_edit_small"), forState: .Normal)
        self.addSubview(editUserDescButton)
        
        
        // 排行榜
        rollRankListView = PPRollContributionListView()
        /* some kind of data binding in the future. */
        self.addSubview(rollRankListView)
        
        // 按钮containerView
        buttonsContainerView = UIView()
        self.addSubview(buttonsContainerView)
        
        broadcastButton                       = CountButton()
        broadcastButton.numberCountLabel.text = "99"
        broadcastButton.typeStr.text          = "直播"
        buttonsContainerView.addSubview(broadcastButton)
        
        momentsButton                       = CountButton()
        momentsButton.typeStr.text          = "动态"
        momentsButton.numberCountLabel.text = "86"
        buttonsContainerView.addSubview(momentsButton)
        
        followingButton                       = CountButton()
        followingButton.typeStr.text          = "关注"
        followingButton.numberCountLabel.text = "20"
        buttonsContainerView.addSubview(followingButton)
        
        fansButton                       = CountButton()
        fansButton.typeStr.text          = "粉丝"
        fansButton.numberCountLabel.text = "22"
        buttonsContainerView.addSubview(fansButton)
        
        headerSeparatorView = UIImageView(image: UIImage(named: "cell_separator"))
        self.addSubview(headerSeparatorView)
    }
    
    private func setupConstraints(){
        avatarImageView.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(25)
            make.centerX.equalTo(self)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        usernameLabel.snp_makeConstraints { (make) in
            make.top.equalTo(avatarImageView.snp_bottom).offset(11)
            make.centerX.equalTo(self)
        }
        
        userDescLabel.snp_makeConstraints { (make) in
            make.top.equalTo(usernameLabel.snp_bottom).offset(3)
            make.centerX.equalTo(self)
        }
        
        editUserDescButton.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 15, height: 15))
            make.left.equalTo(userDescLabel.snp_right).offset(3)
            make.centerY.equalTo(userDescLabel)
        }
        
        rollRankListView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(50)
            make.top.equalTo(userDescLabel.snp_bottom).offset(28)
        }
        
        buttonsContainerView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(rollRankListView.snp_bottom)
            make.height.equalTo(55)
        }
        
        broadcastButton.snp_makeConstraints { (make) in
            make.top.left.bottom.equalTo(buttonsContainerView)
        }
        
        momentsButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(buttonsContainerView)
            make.left.equalTo(broadcastButton.snp_right)
            make.width.equalTo(broadcastButton)
        }
        
        followingButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(buttonsContainerView)
            make.left.equalTo(momentsButton.snp_right)
            make.width.equalTo(momentsButton)
        }
        
        fansButton.snp_makeConstraints { (make) in
            make.top.bottom.right.equalTo(buttonsContainerView)
            make.left.equalTo(followingButton.snp_right)
            make.width.equalTo(followingButton)
        }
        
        headerSeparatorView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(buttonsContainerView.snp_bottom)
            make.height.equalTo(10)
        }

    }

}
