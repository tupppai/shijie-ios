//
//  PPLiveShareView.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/10.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPLiveShareView: UIView {
    
    private var shareToLabel: UILabel!
    
    private var shareButtonsContainerView: UIView!
    
    private var weixinButton: UIButton!
    
    private var momentButton: UIButton!
    
    private var weiboButton: UIButton!
    
    private var qqButton: UIButton!
    
    private var goBackHomeButton: UIButton!
    
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
        self.backgroundColor = UIColor.clearColor()
        
        // "分享到"label
        shareToLabel               = UILabel()
        shareToLabel.text          = "分享到"
        shareToLabel.textColor     = UIColor.whiteColor()
        shareToLabel.textAlignment = .Center
        shareToLabel.font          = UIFont.systemFontOfSize(12)
        self.addSubview(shareToLabel)
        
        // containerView for buttons
        shareButtonsContainerView = UIView()
        shareButtonsContainerView.backgroundColor = UIColor.clearColor()
        self.addSubview(shareButtonsContainerView)
        
        // 微信button
        weixinButton = UIButton()
        weixinButton.setImage(UIImage(named: "live-share-wechat"), forState: .Normal)
        weixinButton.contentMode = .Center
        shareButtonsContainerView.addSubview(weixinButton)
        
        // 朋友圈button
        momentButton = UIButton()
        momentButton.setImage(UIImage(named: "live-share-WechatMoment"), forState: .Normal)
        momentButton.contentMode = .Center
        shareButtonsContainerView.addSubview(momentButton)
        
        // 微博button
        weiboButton = UIButton()
        weiboButton.setImage(UIImage(named: "live-share-sinaweibo"), forState: .Normal)
        weiboButton.contentMode = .Center
        shareButtonsContainerView.addSubview(weiboButton)
        
        // qq button
        qqButton = UIButton()
        qqButton.setImage(UIImage(named: "live-share-QQ"), forState: .Normal)
        qqButton.contentMode = .Center
        shareButtonsContainerView.addSubview(qqButton)
        
        // 返回首页 button
        goBackHomeButton = UIButton()
        goBackHomeButton.setImage(UIImage(named: "btn_backHome"), forState: .Normal)
        self.addSubview(goBackHomeButton)
        
    }
    
    private func setupConstraints(){
        shareToLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }
        
        shareButtonsContainerView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(shareToLabel.snp_bottom).offset(20)
            make.height.equalTo(20)
        }
        
        goBackHomeButton.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(shareButtonsContainerView.snp_bottom).offset(25)
            make.height.equalTo(40)
        }
        
        // 4等分containerView
        weixinButton.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(shareButtonsContainerView)
        }
        
        momentButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(shareButtonsContainerView)
            make.left.equalTo(weixinButton.snp_right)
            make.width.equalTo(weixinButton.snp_width)
        }
        
        weiboButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(shareButtonsContainerView)
            make.left.equalTo(momentButton.snp_right)
            make.width.equalTo(momentButton.snp_width)
        }
        
        qqButton.snp_makeConstraints { (make) in
            make.top.bottom.right.equalTo(shareButtonsContainerView)
            make.left.equalTo(weiboButton.snp_right)
            make.width.equalTo(weiboButton.snp_width)
        }
    }
}
