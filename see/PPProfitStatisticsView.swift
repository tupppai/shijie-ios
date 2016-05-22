//
//  PPProfitStatisticsView.swift
//  see
//
//  Created by TUPAI-Huangwei on 16/5/21.
//  Copyright © 2016年 pires.inc. All rights reserved.
//

import UIKit

class PPProfitStatisticsView: UIView {

    private var myRollsDescLabel: UILabel!
    
    private var myRollsCountLabel: UILabel!
    
    private var rollsAvailableDescLabel: UILabel!
    
    private var rollsAvailableCountLabel: UILabel!
    
    private var rollsAvailableTodayDescLabel: UILabel!
    
    private var rollsAvailableTodayCountLabel: UILabel!
    
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
        
        setupGradientBackground()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupGradientBackground(){
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds;
        gradientLayer.colors = [UIColor(hex: 0xFA6421).CGColor, UIColor(hex: 0xFF7C4C).CGColor]
        gradientLayer.startPoint = CGPoint(x: gradientLayer.frame.size.width / 2, y: 0)
        gradientLayer.endPoint   = CGPoint(x: gradientLayer.frame.size.width / 2, y: gradientLayer.frame.size.height)
        self.layer.addSublayer(gradientLayer)
    }
    
    private func setupSubviews(){
        myRollsDescLabel               = UILabel()
        myRollsDescLabel.text          = "我的视卷"
        myRollsDescLabel.textColor     = UIColor(hex: 0xFFFFFF, alpha: 0.6)
        myRollsDescLabel.textAlignment = .Center
        myRollsDescLabel.font          = UIFont.systemFontOfSize(12)
        self.addSubview(myRollsDescLabel)
        
        myRollsCountLabel               = UILabel()
        myRollsCountLabel.text          = "52"
        myRollsCountLabel.textColor     = UIColor.whiteColor()
        myRollsCountLabel.textAlignment = .Center
        myRollsCountLabel.font          = UIFont.systemFontOfSize(47)
        self.addSubview(myRollsCountLabel)
        
        rollsAvailableDescLabel               = UILabel()
        rollsAvailableDescLabel.text          = "可提现金额"
        rollsAvailableDescLabel.textColor     = UIColor(hex: 0xFFFFFF, alpha: 0.6)
        rollsAvailableDescLabel.textAlignment = .Left
        rollsAvailableDescLabel.font          = UIFont.systemFontOfSize(12)
        self.addSubview(rollsAvailableDescLabel)
        
        rollsAvailableCountLabel               = UILabel()
        rollsAvailableCountLabel.text          = "1210.00元"
        rollsAvailableCountLabel.textColor     = UIColor.whiteColor()
        rollsAvailableCountLabel.textAlignment = .Left
        rollsAvailableCountLabel.font          = UIFont.systemFontOfSize(18)
        self.addSubview(rollsAvailableCountLabel)
        
        rollsAvailableTodayDescLabel               = UILabel()
        rollsAvailableTodayDescLabel.text          = "今日可提现的金额"
        rollsAvailableTodayDescLabel.textColor     = UIColor(hex: 0xFFFFFF, alpha: 0.6)
        rollsAvailableTodayDescLabel.textAlignment = .Right
        rollsAvailableTodayDescLabel.font          = UIFont.systemFontOfSize(12)
        self.addSubview(rollsAvailableTodayDescLabel)
        
        rollsAvailableTodayCountLabel               = UILabel()
        rollsAvailableTodayCountLabel.text          = "200.00元"
        rollsAvailableTodayCountLabel.textColor     = UIColor.whiteColor()
        rollsAvailableTodayCountLabel.font          = UIFont.systemFontOfSize(18)
        rollsAvailableTodayCountLabel.textAlignment = .Right
        self.addSubview(rollsAvailableTodayCountLabel)
    }
    
    private func setupConstraints(){
        myRollsDescLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(20)
        }
        
        myRollsCountLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(myRollsDescLabel.snp_bottom).offset(15)
        }
        
        rollsAvailableCountLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.bottom.equalTo(self).offset(-23)
        }
        
        rollsAvailableDescLabel.snp_makeConstraints { (make) in
            make.left.equalTo(rollsAvailableCountLabel)
            make.bottom.equalTo(rollsAvailableCountLabel.snp_top).offset(-7)
        }
        
        rollsAvailableTodayCountLabel.snp_makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(rollsAvailableCountLabel)
        }
        
        rollsAvailableTodayDescLabel.snp_makeConstraints { (make) in
            make.right.equalTo(rollsAvailableTodayCountLabel)
            make.top.equalTo(rollsAvailableDescLabel)
        }
    }
}
