//
//  PPVIPCommitSuccessPanelView.swift
//  see
//
//  Created by TUPAI-Huangwei on 16/5/20.
//  Copyright © 2016年 pires.inc. All rights reserved.
//

import UIKit

class PPVIPCommitSuccessPanelView: UIView {
    
    var okButton: UIButton!
    
    // MARK: Init methods
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    convenience init(){
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: UI setup
    private func commonInit(){
        self.backgroundColor = UIColor.whiteColor()
        setupSubviews()
    }
    
    private func setupSubviews(){
        let upperOrangeBackgroundView = UIView()
        upperOrangeBackgroundView.backgroundColor = UIColor(hex: 0xFF744A)
        self.addSubview(upperOrangeBackgroundView)
        
        let descLabel           = UILabel()
        descLabel.text          = "将会在1个工作日之内审核完毕，请留意系统消息，谢谢"
        descLabel.textColor     = UIColor(hex: 0x747482)
        descLabel.font          = UIFont.systemFontOfSize(17)
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .Center
        self.addSubview(descLabel)
        
        okButton = UIButton()
        okButton.setTitle("OK", forState: .Normal)
        okButton.setTitleColor(UIColor(hex: 0x7ED321), forState: .Normal)
        okButton.titleLabel?.font = UIFont.systemFontOfSize(22)
        okButton.contentMode = .Center
        self.addSubview(okButton)
        
        let flagWithHeartImageView = UIImageView(image: UIImage(named: "ic_flag_with_heart"))
        flagWithHeartImageView.contentMode = .Center
        upperOrangeBackgroundView.addSubview(flagWithHeartImageView)
        
        let commitSuccessLabel = UILabel()
        commitSuccessLabel.text = "提交成功"
        commitSuccessLabel.textColor = UIColor.whiteColor()
        commitSuccessLabel.font = UIFont.systemFontOfSize(22)
        commitSuccessLabel.textAlignment = .Center
        upperOrangeBackgroundView.addSubview(commitSuccessLabel)
        
        // add constraints
        upperOrangeBackgroundView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(85)
        }
        
        descLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(30)
            make.right.equalTo(self).offset(-30)
            make.top.equalTo(upperOrangeBackgroundView.snp_bottom).offset(25)
        }
        
        okButton.snp_makeConstraints { (make) in
            make.left.right.equalTo(descLabel)
            make.bottom.equalTo(self)
            make.top.equalTo(descLabel.snp_bottom).offset(25)
        }
        
        flagWithHeartImageView.snp_makeConstraints { (make) in
            make.centerY.equalTo(upperOrangeBackgroundView)
            make.centerX.equalTo(upperOrangeBackgroundView).offset(-40)
            make.size.equalTo(CGSize(width: 33, height: 32))
        }
        
        commitSuccessLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(upperOrangeBackgroundView).offset(-4)
            make.left.equalTo(flagWithHeartImageView.snp_right).offset(13)
        }
    }
    
    
}
