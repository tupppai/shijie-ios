//
//  PPHostReceivedCoinView.swift
//  live
//
//  Created by chenpeiwei on 3/18/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPHostReceivedCoinView: UIView {
    
    var assitLabel:UILabel!
    var countLabel:UILabel!
    var iconLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(hex: 0x000000, alpha: 0.5)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        assitLabel = UILabel()
        assitLabel.textColor = UIColor.whiteColor()
        assitLabel.font = UIFont.systemFontOfSize(13)
        
        countLabel = UILabel()
        countLabel.textColor = UIColor.whiteColor()
        countLabel.font = UIFont.systemFontOfSize(13)
        countLabel.textAlignment = .Center
        
        iconLabel = UILabel()
        iconLabel.textColor = UIColor.whiteColor()
        iconLabel.font = UIFont.systemFontOfSize(13)
        
        assitLabel.text = "视券"
        countLabel.text = "666"
        iconLabel.text = ">"

        self.addSubview(assitLabel)
        self.addSubview(countLabel)
        self.addSubview(iconLabel)

        assitLabel.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(self).offset(11)
            make.centerY.equalTo(self)
            make.width.equalTo(26)
        }
        countLabel.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(assitLabel.snp_trailing).offset(5)
            make.centerY.equalTo(self)
        }
        iconLabel.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(countLabel.snp_trailing).offset(3)
            make.centerY.equalTo(self)
            make.trailing.equalTo(self).offset(-5)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
