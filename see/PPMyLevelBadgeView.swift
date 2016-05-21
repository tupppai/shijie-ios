//
//  PPMyLevelBadgeView.swift
//  see
//
//  Created by TUPAI-Huangwei on 16/5/21.
//  Copyright © 2016年 pires.inc. All rights reserved.
//

import UIKit

class PPMyLevelBadgeView: UIView {

    private var upperOrangeBackgroundView: UIView!
    
    private var levelBadgeImageView: UIImageView!
    
//    private var levelStr = "12"
    private var levelStrLabel: UILabel!
    
    private var levelProgressView: UIProgressView!
    
    private var experienceRatioLabel: UILabel!
    
    private var experienceDescLabel: UILabel!
    
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
    
    private func commonInit(){
        self.backgroundColor = UIColor.whiteColor()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews(){
        upperOrangeBackgroundView = UIView()
        upperOrangeBackgroundView.backgroundColor = UIColor(hex: 0xFF8560)
        self.addSubview(upperOrangeBackgroundView)
        
        levelBadgeImageView = UIImageView()
        levelBadgeImageView.image = UIImage(named: "ic_levelBadge")
        levelBadgeImageView.contentMode = .Center
        self.addSubview(levelBadgeImageView)
        
        levelStrLabel = UILabel()
        levelStrLabel.text = "12"
        levelStrLabel.textColor = UIColor.whiteColor()
        levelStrLabel.font = UIFont.systemFontOfSize(45)
        levelStrLabel.textAlignment = .Center
        levelBadgeImageView.addSubview(levelStrLabel)
        
        levelProgressView = UIProgressView(progressViewStyle: .Bar)
        levelProgressView.trackTintColor = UIColor(hex: 0xC8C8D4)
        levelProgressView.progressTintColor = UIColor(hex: 0xFF744A)
        levelProgressView.setProgress(0.5, animated: false)
        self.addSubview(levelProgressView)
        
        experienceRatioLabel = UILabel()
        experienceRatioLabel.text = "114/250"
        experienceRatioLabel.textColor = UIColor(hex: 0xFF744A)
        experienceRatioLabel.textAlignment = .Left
        experienceRatioLabel.font = UIFont.systemFontOfSize(12)
        self.addSubview(experienceRatioLabel)
        
        experienceDescLabel = UILabel()
        experienceDescLabel.text = "距离Lv.14还差223经验值"
        experienceDescLabel.textColor = UIColor(hex: 0xFF744A)
        experienceDescLabel.textAlignment = .Right
        experienceDescLabel.font = UIFont.systemFontOfSize(12)
        self.addSubview(experienceDescLabel)
    }
    
    private func setupConstraints(){
        upperOrangeBackgroundView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(79)
        }
        
        levelBadgeImageView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(12)
            make.size.equalTo(CGSize(width: 150, height: 125))
        }
        
        levelStrLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(levelBadgeImageView)
            make.bottom.equalTo(levelBadgeImageView.snp_centerY).offset(10)
        }
        
        levelProgressView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.top.equalTo(levelBadgeImageView.snp_bottom).offset(30)
        }
        
        experienceRatioLabel.snp_makeConstraints { (make) in
            make.left.equalTo(levelProgressView.snp_left)
            make.top.equalTo(levelProgressView.snp_bottom).offset(11)
        }
        
        experienceDescLabel.snp_makeConstraints { (make) in
            make.right.equalTo(levelProgressView.snp_right)
            make.top.equalTo(experienceRatioLabel)
        }

    }
}
