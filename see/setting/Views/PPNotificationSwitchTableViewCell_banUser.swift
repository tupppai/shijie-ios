//
//  PPNotificationSwitchTableViewCell_banUser.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/13.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPNotificationSwitchTableViewCell_banUser: UITableViewCell {

    var avatarImageView : PPRoundImageView!
    
    var usernameLabel: UILabel!
    
    var userDescLabel: UILabel!
    
    var genderImageView: UIImageView!
    
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
        avatarImageView = PPRoundImageView(image: UIImage(named: "avatar_example5"))
        self.contentView.addSubview(avatarImageView)
        
        usernameLabel               = UILabel()
        usernameLabel.text          = "呵呵干嘛在洗澡~"
        usernameLabel.textColor     = UIColor.blackColor()
        usernameLabel.textAlignment = .Left
        usernameLabel.font          = UIFont.systemFontOfSize(14)
        self.contentView.addSubview(usernameLabel)
        
        userDescLabel = UILabel()
        userDescLabel.text = "粉丝热捧的新晋女演员"
        userDescLabel.textColor = UIColor(hex: 0x000000, alpha: 0.3)
        userDescLabel.font = UIFont.systemFontOfSize(11)
        userDescLabel.textAlignment = .Left
        self.contentView.addSubview(userDescLabel)
        
        genderImageView = UIImageView(image: UIImage(named: "ic_gender_female"))
        genderImageView.contentMode = .Center
        self.contentView.addSubview(genderImageView)
     
        notificationSwitch = UISwitch()
        notificationSwitch.on = false
        notificationSwitch.onTintColor = UIColor(hex: 0xFF744A)
        self.contentView.addSubview(notificationSwitch)
        
        avatarImageView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(12)
        }
        
        usernameLabel.snp_makeConstraints { (make) in
            make.top.equalTo(avatarImageView)
            make.left.equalTo(avatarImageView.snp_right).offset(10)
        }
        
        userDescLabel.snp_makeConstraints { (make) in
            make.left.equalTo(usernameLabel)
            make.top.equalTo(usernameLabel.snp_bottom).offset(9)
        }
        
        genderImageView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 14, height: 14))
            make.centerY.equalTo(usernameLabel)
            make.left.equalTo(usernameLabel.snp_right).offset(4)
        }
        
        notificationSwitch.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-12)
        }
        
    }
    
}
