//
//  PPFriendActionToolbar.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/16.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

enum PPFriendActionToolbarButtonType {
    case Follow
    case PrivateMessage
    case BanUser
}

protocol PPFriendActionToolbarDelegate : class {
    
    func toolbar(toolbar: PPFriendActionToolbar, didTapButton buttonType: PPFriendActionToolbarButtonType)
    
}

class PPFriendActionToolbar: UIView {
    
    weak var delegate:PPFriendActionToolbarDelegate?
    
    private var followButton: UIButton!
    
    private var privateMessageButton: UIButton!
    
    private var banUserButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // UI setup
    private func commonInit(){
        self.backgroundColor = UIColor(hex: 0xE5E5E5)
        followButton         =
            setupToolbarButton("关注", titleColor: UIColor(hex: 0xFF5722), iconImage: UIImage(named: "btn_addFollow")!)
        privateMessageButton =
            setupToolbarButton("私信", titleColor: UIColor(hex: 0x000000, alpha: 0.8), iconImage: UIImage(named: "btn_privateMessage")!)
        banUserButton        =
            setupToolbarButton("拉黑", titleColor: UIColor(hex: 0x000000, alpha: 0.8), iconImage: UIImage(named: "btn_banUser")!)
        
        
        self.addSubview(followButton)
        self.addSubview(privateMessageButton)
        self.addSubview(banUserButton)
        
        followButton.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
        }
        
        privateMessageButton.snp_makeConstraints { (make) in
            make.left.equalTo(followButton.snp_right).offset(1)
            make.top.bottom.equalTo(self)
            make.width.equalTo(followButton)
        }
        
        banUserButton.snp_makeConstraints { (make) in
            make.left.equalTo(privateMessageButton.snp_right).offset(1)
            make.top.bottom.right.equalTo(self)
            make.width.equalTo(privateMessageButton)
        }
        
        // add target actions
        
        followButton.addTarget(self, action: #selector(self.tapFollowButton), forControlEvents: .TouchUpInside)
        privateMessageButton.addTarget(self, action: #selector(self.tapPrivateMessageButton), forControlEvents: .TouchUpInside)
        banUserButton.addTarget(self, action: #selector(self.tapBanUserButton), forControlEvents: .TouchUpInside)
        
    }
    
    // MARK: Target-actions
    func tapFollowButton(){
        delegate?.toolbar(self, didTapButton: .Follow)
    }
    
    func tapPrivateMessageButton(){
        delegate?.toolbar(self, didTapButton: .PrivateMessage)
    }
    
    func tapBanUserButton(){
        delegate?.toolbar(self, didTapButton: .BanUser)
    }
    
    // MARK:  Private helper
    private func setupToolbarButton(title:String, titleColor: UIColor,iconImage: UIImage) -> UIButton{
        let button = UIButton()
        button.backgroundColor = UIColor.whiteColor()
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(titleColor, forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        button.setImage(iconImage, forState: .Normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return button
    }
    
}
