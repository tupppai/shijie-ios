//
//  PPRollContributionListView.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/12.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPRollContributionListView: UIView {

    var avatarImageView1: PPRoundImageView!
    
    var avatarImageView2: PPRoundImageView!
    
    var avatarImageView3: PPRoundImageView!
    
    var rightIndicatorLabel: UILabel!

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
    
    // MARK: UI setup
    private func setupSubviews(){
        avatarImageView1 = PPRoundImageView(image: UIImage(named: "avatar_example5"))
        self.addSubview(avatarImageView1)
        
        avatarImageView2 = PPRoundImageView(image: UIImage(named: "avatar_example6"))
        self.addSubview(avatarImageView2)
        
        avatarImageView3 = PPRoundImageView(image: UIImage(named: "avatar_example7"))
        self.addSubview(avatarImageView3)
        
        rightIndicatorLabel = UILabel()
        rightIndicatorLabel.text = "see币贡献榜 >"
        rightIndicatorLabel.textColor = UIColor.blackColor()
        rightIndicatorLabel.textAlignment = .Right
        rightIndicatorLabel.font = UIFont.systemFontOfSize(12)
        self.addSubview(rightIndicatorLabel)
    }
    
    private func setupConstraints(){
        avatarImageView1.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(12)
        }
        
        avatarImageView2.snp_makeConstraints { (make) in
            make.size.equalTo(avatarImageView1.snp_size)
            make.centerY.equalTo(self)
            make.left.equalTo(avatarImageView1.snp_right).offset(5)
        }
        
        avatarImageView3.snp_makeConstraints { (make) in
            make.size.equalTo(avatarImageView1)
            make.centerY.equalTo(self)
            make.left.equalTo(avatarImageView2.snp_right).offset(5)
        }
        
        rightIndicatorLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-12)
        }
    }

}
