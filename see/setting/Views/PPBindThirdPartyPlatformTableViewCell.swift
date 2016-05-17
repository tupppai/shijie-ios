//
//  PPBindThirdPartyPlatformTableViewCell.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/13.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPBindThirdPartyPlatformTableViewCell: UITableViewCell {

    var iconImageView : UIImageView!
    
    var descLabel : UILabel!
    
    var bindButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: UI setup
    
    private func commonInit(){
        iconImageView = UIImageView()
        iconImageView.contentMode = .Center
        self.contentView.addSubview(iconImageView)
        
        descLabel = UILabel()
        descLabel.textColor = UIColor.blackColor()
        descLabel.textAlignment = .Left
        descLabel.font = UIFont.systemFontOfSize(14)
        self.contentView.addSubview(descLabel)
        
        bindButton = UIButton()
        bindButton.setBackgroundImage(UIImage(named: "btn_small_orange"), forState: .Normal)
        bindButton.setTitle("绑定", forState: .Normal)
        bindButton.setBackgroundImage(UIImage(named: "btn_grey_small"), forState: .Highlighted)
        bindButton.setTitle("解绑", forState: .Highlighted)
        bindButton.titleLabel?.font = UIFont.systemFontOfSize(11)
        self.contentView.addSubview(bindButton)
        
        iconImageView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(16)
        }
        
        descLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(iconImageView.snp_right).offset(16)
        }
        
        bindButton.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 50, height: 25))
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-16)
        }
    }
    
    
    
}
