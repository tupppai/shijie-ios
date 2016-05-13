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
    
    private var shareButtonsContainerView: PPLiveShareButtonsView!
    
    var goBackHomeButton: UIButton!
    
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
        shareButtonsContainerView = PPLiveShareButtonsView()
        self.addSubview(shareButtonsContainerView)
        
        // 返回首页 button
        goBackHomeButton = UIButton()
        goBackHomeButton.setBackgroundImage(UIImage(named: "btn_big"), forState: .Normal)
        goBackHomeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        goBackHomeButton.setTitle("返回首页", forState: .Normal)
        goBackHomeButton.titleLabel!.font = UIFont.systemFontOfSize(14)
        goBackHomeButton.contentMode = .Center
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
            make.height.equalTo(48)
        }
    }
}
