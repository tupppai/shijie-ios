//
//  PPEditAvatarCell.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/13.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPEditAvatarCell: UITableViewCell {

    private var avatarLabel: UILabel!
    
    private var avatarImageView: PPRoundImageView!
    
    private var rightIndicator: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func commonInit(){
        
        avatarLabel = UILabel()
        avatarLabel.text = "头像"
        avatarLabel.textColor = UIColor.blackColor()
        avatarLabel.font = UIFont.systemFontOfSize(14)
        avatarLabel.textAlignment = .Left
        self.contentView.addSubview(avatarLabel)
        
        avatarImageView = PPRoundImageView(image: (UIImage(named: "avatar_example5")))
        self.contentView.addSubview(avatarImageView)
        
        rightIndicator  = UIImageView(image: (UIImage(named: "icon_segueRight")))
        self.contentView.addSubview(rightIndicator)
        
        
        avatarLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(16)
        }
        
        rightIndicator.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 6, height: 11))
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-16)
        }
        
        avatarImageView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(rightIndicator.snp_left).offset(-10)
        }
        
    }

}
