//
//  PPCoinsRankView.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/10.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPCoinsRankView: UIView {

    private var firstGradeImageView: PPRoundImageView!
    
    private var secondGradeImageView: PPRoundImageView!
    
    private var thirdGradeImageView: PPRoundImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    convenience init(){
        self.init(frame: CGRect.zero)
    }
    
    // UI setup
    private func commonInit(){
        //三皇冠并列
        self.backgroundColor = UIColor.whiteColor()
        
        firstGradeImageView  = PPRoundImageView(image: UIImage(named: "avatar_small_1"))
        secondGradeImageView = PPRoundImageView(image: UIImage(named: "avatar_small_2"))
        thirdGradeImageView  = PPRoundImageView(image: UIImage(named: "avatar_small_3"))
        
        firstGradeImageView.layer.borderWidth  = 2
        secondGradeImageView.layer.borderWidth = 2
        thirdGradeImageView.layer.borderWidth  = 2

        firstGradeImageView.layer.borderColor  = UIColor(hex: 0xF8E71C).CGColor
        secondGradeImageView.layer.borderColor = UIColor(hex: 0xFFA403).CGColor
        thirdGradeImageView.layer.borderColor  = UIColor(hex: 0xD0D0D0).CGColor
        
        self.addSubview(firstGradeImageView)
        self.addSubview(secondGradeImageView)
        self.addSubview(thirdGradeImageView)
        
        let firstCrown  = UIImageView(image: UIImage(named: "ic_no1"))
        let secondCrown = UIImageView(image: UIImage(named: "ic_no2"))
        let thirdCrown  = UIImageView(image: UIImage(named: "ic_no3"))
        
        self.addSubview(firstCrown)
        self.addSubview(secondCrown)
        self.addSubview(thirdCrown)
        
        
        firstGradeImageView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.centerY.equalTo(self)
            make.left.equalTo(self)
        }
        
        secondGradeImageView.snp_makeConstraints { (make) in
            make.size.equalTo(firstGradeImageView.snp_size)
            make.centerY.equalTo(self)
            make.left.equalTo(firstGradeImageView.snp_right).offset(5)
        }
        
        thirdGradeImageView.snp_makeConstraints { (make) in
            make.size.equalTo(secondGradeImageView.snp_size)
            make.centerY.equalTo(self)
            make.left.equalTo(secondGradeImageView.snp_right).offset(5)
        }
        
        firstCrown.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 10, height: 10))
            make.top.equalTo(firstGradeImageView).offset(-1)
            make.right.equalTo(firstGradeImageView).offset(3)
        }
        
        secondCrown.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 10, height: 10))
            make.top.equalTo(secondGradeImageView).offset(-1)
            make.right.equalTo(secondGradeImageView).offset(3)
        }
        
        thirdCrown.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 10, height: 10))
            make.top.equalTo(thirdGradeImageView).offset(-1)
            make.right.equalTo(thirdGradeImageView).offset(3)
        }
        
        
    }
    
}
