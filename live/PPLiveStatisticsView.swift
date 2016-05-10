//
//  PPLiveStatisticsView.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/10.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPLiveStatisticsView: UIView {

    private var timeElapsedLabel: UILabel!
    
    private var timeDescLabel: UILabel!
    
    private var audienceLabel: UILabel!
    
    private var audienceCountLabel: UILabel!
    
    private var coinsLabel: UILabel!
    
    private var coinsCountLabel: UILabel!
    
    private var coinsRankLabel: UILabel!
    
    private var coinsRankView: PPCoinsRankView!
    
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
        self.backgroundColor = UIColor.whiteColor()
        
        // 直播时长label
        timeElapsedLabel               = UILabel()
        timeElapsedLabel.text          = "00:11:34"
        timeElapsedLabel.textColor     = UIColor(hex: 0xFF5722)
        timeElapsedLabel.font          = UIFont.systemFontOfSize(38)
        timeElapsedLabel.textAlignment = .Center
        self.addSubview(timeElapsedLabel)
        
        // 直播desc Label
        timeDescLabel           = UILabel()
        timeDescLabel.text      = "直播总时长"
        timeDescLabel.textColor = UIColor(hex: 0x525877)
        timeDescLabel.font      = UIFont.systemFontOfSize(12)
        self.addSubview(timeDescLabel)
        
        // 观众人数
        audienceLabel           = UILabel()
        audienceLabel.text      = "观众人数"
        audienceLabel.textColor = UIColor(hex: 0x525877)
        audienceLabel.font      = UIFont.systemFontOfSize(14)
        self.addSubview(audienceLabel)
        
        audienceCountLabel               = UILabel()
        audienceCountLabel.text          = "1,123"
        audienceCountLabel.textColor     = UIColor(hex: 0xFF5722)
        audienceCountLabel.textAlignment = .Right
        audienceCountLabel.font          = UIFont.systemFontOfSize(20)
        self.addSubview(audienceCountLabel)
        
        // 收获视票
        coinsLabel               = UILabel()
        coinsLabel.text          = "收获视票"
        coinsLabel.textColor     = UIColor(hex: 0x525877)
        coinsLabel.textAlignment = .Center
        coinsLabel.font          = UIFont.systemFontOfSize(14)
        self.addSubview(coinsLabel)
        
        coinsCountLabel               = UILabel()
        coinsCountLabel.text          = "1,1233434343"
        coinsCountLabel.textColor     = UIColor(hex: 0xFF5722)
        coinsCountLabel.font          = UIFont.systemFontOfSize(20)
        coinsCountLabel.textAlignment = .Right
        self.addSubview(coinsCountLabel)
        
        // 贡献最多
        coinsRankLabel = UILabel()
        coinsRankLabel.text = "贡献最多"
        coinsRankLabel.font = UIFont.systemFontOfSize(14)
        coinsRankLabel.textColor = UIColor(hex: 0x525877)
        self.addSubview(coinsRankLabel)
        
        coinsRankView = PPCoinsRankView()
        self.addSubview(coinsRankView)
    }
    
    private func setupConstraints(){
        timeElapsedLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(30)
        }
        
        timeDescLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(timeElapsedLabel.snp_bottom).offset(10)
        }
        
        audienceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(30)
            make.top.equalTo(timeDescLabel.snp_bottom).offset(45)
        }
        
        audienceCountLabel.snp_makeConstraints { (make) in
            make.top.equalTo(audienceLabel)
            make.right.equalTo(self).offset(-30)
        }
        
        coinsLabel.snp_makeConstraints { (make) in
            make.left.equalTo(audienceLabel)
            make.top.equalTo(audienceLabel.snp_bottom).offset(25)
        }
        
        coinsCountLabel.snp_makeConstraints { (make) in
            make.top.equalTo(coinsLabel)
            make.right.equalTo(self).offset(-30)
        }
        
        coinsRankLabel.snp_makeConstraints { (make) in
            make.left.equalTo(coinsLabel)
            make.top.equalTo(coinsLabel.snp_bottom).offset(25)
        }
        
        coinsRankView.snp_makeConstraints { (make) in
            make.height.equalTo(40)
            make.centerY.equalTo(coinsRankLabel)
            make.left.equalTo(coinsRankLabel.snp_right).offset(11)
            make.right.equalTo(self).offset(-20)
        }
        
    }
    
}
