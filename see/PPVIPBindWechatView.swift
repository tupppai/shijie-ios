//
//  PPVIPBindWechatView.swift
//  see
//
//  Created by TUPAI-Huangwei on 16/5/20.
//  Copyright © 2016年 pires.inc. All rights reserved.
//

import UIKit

class PPVIPBindWechatView: UIView {
    
    private var wechatIconImageView: UIImageView!
    
    private var bindPromptLabel: UILabel!
    
    private var detailDisclosureImageView: UIImageView!
    
    private var avatarImageView: PPRoundImageView!
    
    private var userNameLabel: UILabel!
    
    var bindWechatClosure: (() -> Void)?
    
    // MARK: Init methods
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        setupSubviews()
        setupConstraints()
        setUnbindStatus()
        setupTapActions()
    }
    
    convenience init(){
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
        setupConstraints()
        setupTapActions()
    }
    
    // MARK : Setup UI
    private func setupSubviews(){
        wechatIconImageView = UIImageView(image: UIImage(named: "ic_wechat_hollow_small"))
        wechatIconImageView.userInteractionEnabled = false
        wechatIconImageView.contentMode = .Center
        self.addSubview(wechatIconImageView)
        
        bindPromptLabel = UILabel()
        bindPromptLabel.text = "立即绑定"
        bindPromptLabel.textColor = UIColor(hex: 0xFF5722)
        bindPromptLabel.font = UIFont.systemFontOfSize(14)
        bindPromptLabel.userInteractionEnabled = false
        self.addSubview(bindPromptLabel)
        
        detailDisclosureImageView = UIImageView(image: UIImage(named: "icon_segueRight"))
        detailDisclosureImageView.contentMode = .Center
        detailDisclosureImageView.userInteractionEnabled = false
        self.addSubview(detailDisclosureImageView)
        
        avatarImageView             = PPRoundImageView()
        avatarImageView.contentMode = .Center
        avatarImageView.userInteractionEnabled = false
        self.addSubview(avatarImageView)
        
        userNameLabel               = UILabel()
        userNameLabel.textColor     = UIColor.blackColor()
        userNameLabel.font          = UIFont.systemFontOfSize(14)
        avatarImageView.userInteractionEnabled = false
        userNameLabel.textAlignment = .Right
        self.addSubview(userNameLabel)
    }
    
    private func setupConstraints(){
        wechatIconImageView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 44, height: 44))
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(15)
        }
        
        detailDisclosureImageView.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-12)
            make.size.equalTo(CGSize(width: 5, height: 10))
        }
        
        bindPromptLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(detailDisclosureImageView.snp_left).offset(-10)
        }
        
        userNameLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-15)
        }
        
        avatarImageView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.centerY.equalTo(self)
            make.right.equalTo(userNameLabel.snp_left).offset(-5)
        }
    }
    
    private func setupTapActions(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapOnSelf))
        self.addGestureRecognizer(tap)
    }
    
    // MARK:  Target-actions
    func tapOnSelf(){
        bindWechatClosure?()
    }
    
    // Public methods
    func setUnbindStatus(){
        bindPromptLabel.hidden           = false
        detailDisclosureImageView.hidden = false

        avatarImageView.hidden           = true
        userNameLabel.hidden             = true
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    func setBoundStatus(avatarImage: UIImage, username: String){
        bindPromptLabel.hidden           = true
        detailDisclosureImageView.hidden = true

        avatarImageView.hidden           = false
        userNameLabel.hidden             = false

        userNameLabel.text               = username
        avatarImageView.image            = avatarImage

        setNeedsLayout()
        layoutIfNeeded()
    }
}
