//
//  PPMyLevelDescView.swift
//  see
//
//  Created by TUPAI-Huangwei on 16/5/20.
//  Copyright © 2016年 pires.inc. All rights reserved.
//

import UIKit

class PPMyLevelDescView: UIView {

    override init(frame: CGRect){
        super.init(frame: frame)
        setupSubviews()
    }
    
    convenience init(){
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    private func setupSubviews(){
        self.backgroundColor = UIColor.whiteColor()
        
        let title1 = UILabel()
        title1.text = "等级权益"
        title1.textColor = UIColor(hex: 0x525877)
        title1.textAlignment = .Left
        title1.font = UIFont.systemFontOfSize(15)
        self.addSubview(title1)
        
        let desc1 = UILabel()
        desc1.text = "等级越高身份越尊贵，代表您的成就越高哦"
        desc1.textColor = UIColor(hex: 0x525877)
        desc1.textAlignment = .Left
        desc1.font = UIFont.systemFontOfSize(13)
        self.addSubview(desc1)
        
        let title2 = UILabel()
        title2.text = "如何升级？"
        title2.textColor = UIColor(hex: 0x525877)
        title2.textAlignment = .Left
        title2.font = UIFont.systemFontOfSize(15)
        self.addSubview(title2)
        
        let desc2 = UILabel()
        desc2.text = "·直播更多市场 \n·获得更多视票 \n·送出更多礼物"
        desc2.textColor = UIColor(hex: 0x525877)
        desc2.textAlignment = .Left
        desc2.font = UIFont.systemFontOfSize(13)
        desc2.numberOfLines = 0
        self.addSubview(desc2)
        
        title1.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.left.equalTo(self).offset(15)
        }
        
        desc1.snp_makeConstraints { (make) in
            make.top.equalTo(title1.snp_bottom).offset(10)
            make.left.equalTo(title1)
        }
        
        title2.snp_makeConstraints { (make) in
            make.top.equalTo(desc1.snp_bottom).offset(20)
            make.left.equalTo(desc1)
        }
        
        desc2.snp_makeConstraints { (make) in
            make.top.equalTo(title2.snp_bottom).offset(10)
            make.left.equalTo(title2)
            make.bottom.equalTo(self).offset(-200)
        }
    }
}
