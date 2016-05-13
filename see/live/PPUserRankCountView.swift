//
//  PPUserRankCountView.swift
//  live
//
//  Created by TUPAI-Huangwei on 3/23/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPUserRankCountView: UIView {
    
    var rankCountLabel: UILabel!
    
    var rankCount: Int{
        didSet{
           rankCountLabel.text      = "\(rankCount)"
        }
    }
    
    override init(frame: CGRect){
        rankCount = 0
        super.init(frame: frame)
        setupSubviews()
    }
    
    convenience init(rankCount: Int){
        self.init(frame: CGRect.zero)
        self.rankCount = rankCount
    }
    
    required init?(coder aDecoder: NSCoder) {
        rankCount = 44
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    func setupSubviews(){
        self.backgroundColor = UIColor(hex: 0x6FD6E0)
        let starImageView    = UIImageView(image: UIImage(named: "ic_star_white"))
        self.addSubview(starImageView)
        starImageView.snp_makeConstraints { [weak self] (make) -> Void in
            make.size.equalTo(CGSize(width: 9, height: 8))
            make.centerX.equalTo(self!).offset(-8)
            make.centerY.equalTo(self!)
        }
        
        rankCountLabel           = UILabel()
        rankCountLabel.text      = "\(rankCount)"
        rankCountLabel.font      = UIFont.systemFontOfSize(10)
        rankCountLabel.textColor = UIColor(hex: 0xE2F6F8)
        
        self.addSubview(rankCountLabel)
        rankCountLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(starImageView.snp_right).offset(2)
            make.centerY.equalTo(self)
        }
    }
}
