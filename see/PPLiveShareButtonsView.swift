//
//  PPLiveShareButtonsView.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/11.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPLiveShareButtonsView: UIView {
    private var weixinButton: UIButton!
    
    private var momentButton: UIButton!
    
    private var weiboButton: UIButton!
    
    private var qqButton: UIButton!
    
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
    
    //MARK: UI setup
    private func setupSubviews(){
        self.backgroundColor = UIColor.clearColor()
        
        // 微信button
        weixinButton = UIButton()
        weixinButton.setImage(UIImage(named: "live-share-wechat"), forState: .Normal)
        weixinButton.contentMode = .Center
        self.addSubview(weixinButton)
        
        // 朋友圈button
        momentButton = UIButton()
        momentButton.setImage(UIImage(named: "live-share-WechatMoment"), forState: .Normal)
        momentButton.contentMode = .Center
        self.addSubview(momentButton)
        
        // 微博button
        weiboButton = UIButton()
        weiboButton.setImage(UIImage(named: "live-share-sinaweibo"), forState: .Normal)
        weiboButton.contentMode = .Center
        self.addSubview(weiboButton)
        
        // qq button
        qqButton = UIButton()
        qqButton.setImage(UIImage(named: "live-share-QQ"), forState: .Normal)
        qqButton.contentMode = .Center
        self.addSubview(qqButton)
    }
    
    private func setupConstraints(){
        // 4等分self
        weixinButton.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
        }
        
        momentButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(weixinButton.snp_right)
            make.width.equalTo(weixinButton.snp_width)
        }
        
        weiboButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(momentButton.snp_right)
            make.width.equalTo(momentButton.snp_width)
        }
        
        qqButton.snp_makeConstraints { (make) in
            make.top.bottom.right.equalTo(self)
            make.left.equalTo(weiboButton.snp_right)
            make.width.equalTo(weiboButton.snp_width)
        }
    }
}
