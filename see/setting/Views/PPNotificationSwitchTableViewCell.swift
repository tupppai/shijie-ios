//
//  PPNotificationSwitchTableViewCell.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/13.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPNotificationSwitchTableViewCell: UITableViewCell {

    var mainTitleLabel: UILabel!
    
    var notificationSwitch: UISwitch!
    
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
        
        mainTitleLabel = UILabel()
        mainTitleLabel.text = "直播消息提醒"
        mainTitleLabel.textColor = UIColor.blackColor()
        mainTitleLabel.textAlignment = .Left
        mainTitleLabel.font = UIFont.systemFontOfSize(15)
        self.contentView.addSubview(mainTitleLabel)
        
        notificationSwitch = UISwitch()
        notificationSwitch.onTintColor = UIColor(hex: 0xFF744A)
        notificationSwitch.on = false
        self.contentView.addSubview(notificationSwitch)
        
        mainTitleLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(12)
        }
        
        notificationSwitch.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-12)
        }
        
    }
}
