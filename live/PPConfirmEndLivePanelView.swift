//
//  PPConfirmEndLiveView.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/12.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPConfirmEndLivePanelView: UIView {
    
    var confirmEndLivePromptLabel: UILabel!
    
    var cancelButton: UIButton!
    
    var confirmButton: UIButton!
    
    override init(frame: CGRect){
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
    
    private func setupSubviews(){
        self.backgroundColor = UIColor.clearColor()
        
        
        confirmEndLivePromptLabel = UILabel()
        confirmEndLivePromptLabel.text = "确定要结束直播吗?"
        confirmEndLivePromptLabel.textColor = UIColor.whiteColor()
        confirmEndLivePromptLabel.font = UIFont.systemFontOfSize(20)
        confirmEndLivePromptLabel.textAlignment = .Center
        self.addSubview(confirmEndLivePromptLabel)
        
        cancelButton = UIButton()
        cancelButton.setBackgroundImage(UIImage(named: "btn_small_white"), forState: .Normal)
        cancelButton.setTitle("取消", forState: .Normal)
        cancelButton.setTitleColor(UIColor(hex: 0x747482), forState: .Normal)
        cancelButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        cancelButton.contentMode = .Center
        self.addSubview(cancelButton)
        
        confirmButton = UIButton()
        confirmButton.setBackgroundImage(UIImage(named: "btn_small_orange"), forState: .Normal)
        confirmButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        confirmButton.setTitle("确定", forState: .Normal)
        confirmButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.addSubview(confirmButton)
        
    }
    
    private func setupConstraints(){
        confirmEndLivePromptLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }
        
        cancelButton.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 94, height: 25))
            make.left.bottom.equalTo(self)
        }
        
        confirmButton.snp_makeConstraints { (make) in
            make.size.equalTo(cancelButton.snp_size)
            make.right.bottom.equalTo(self)
        }
        
        
    }
    
}
