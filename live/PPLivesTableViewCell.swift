//
//  PPLivesTableViewCell.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/9.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit
import SnapKit



class PPLivesTableViewCell: UITableViewCell {
    
    var cellSeparatorView: UIImageView!

    var avatarImageView: PPRoundImageView!
    
    var usernameLabel: UILabel!
    
    var updatedTimeLabel: UILabel!
    
    var moreButton: UIButton!
    
    var liveImageView: UIImageView!
    
    var liveTagImageView: UIImageView!
    
    var liveDescLabel: UILabel!
    
    var audienceCountLabel: UILabel!
    
    var coinsCountLabel: UILabel!
    
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
        self.selectionStyle = .None
        
        setupSubviews()
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI setup
    private func setupSubviews(){
        // cell 分隔view
        cellSeparatorView = UIImageView(image: UIImage(named: "cell_separator"))
        self.addSubview(cellSeparatorView)
        
        // 头像
        avatarImageView = PPRoundImageView(image: UIImage(named: "avatar_example_2"))
        self.addSubview(avatarImageView)
        
        // 用户名
        usernameLabel = UILabel()
        usernameLabel.text = "呵呵干嘛去洗澡~"
        usernameLabel.textColor = UIColor.blackColor()
        usernameLabel.textAlignment = .Left
        usernameLabel.font = UIFont.systemFontOfSize(13)
        self.addSubview(usernameLabel)
        
        // 时间
        updatedTimeLabel               = UILabel()
        updatedTimeLabel.text          = "两分钟前"
        updatedTimeLabel.textColor     = UIColor(hex: 0x666666)
        updatedTimeLabel.textAlignment = .Left
        updatedTimeLabel.font          = UIFont.systemFontOfSize(10)
        self.addSubview(updatedTimeLabel)
        
        // more button
        moreButton = UIButton()
        moreButton.setImage(UIImage(named: "icon_more"), forState: .Normal)
        self.addSubview(moreButton)
        
        // live image
        liveImageView = UIImageView(image: UIImage(named: "liveImage_example"))
        liveImageView.contentMode = .ScaleAspectFill
        self.addSubview(liveImageView)
        
        // live tag
        liveTagImageView = UIImageView(image: UIImage(named: "tag_onLive"))
        self.addSubview(liveTagImageView)
        
        // live desc
        liveDescLabel = UILabel()
        liveDescLabel.text = "#直播话题# 直播名称"
        liveDescLabel.textColor = UIColor.whiteColor()
        liveDescLabel.font = UIFont.systemFontOfSize(13)
        self.addSubview(liveDescLabel)
        
        // audience count
        audienceCountLabel = UILabel()
        audienceCountLabel.text = "观众 23"
        audienceCountLabel.textColor = UIColor.whiteColor()
        audienceCountLabel.textAlignment = .Left
        audienceCountLabel.font = UIFont.systemFontOfSize(11)
        self.addSubview(audienceCountLabel)
        
        // coins Count
        coinsCountLabel = UILabel()
        coinsCountLabel.text = "视票 250"
        coinsCountLabel.textColor = UIColor.whiteColor()
        coinsCountLabel.textAlignment = .Left
        coinsCountLabel.font = UIFont.systemFontOfSize(11)
        self.addSubview(coinsCountLabel)
        
    }
    
    private func setupConstraints(){
        cellSeparatorView.snp_makeConstraints { (make) in
            make.height.equalTo(10)
            make.left.top.right.equalTo(self)
        }
        
        avatarImageView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 33, height: 33))
            make.top.equalTo(cellSeparatorView.snp_bottom).offset(10)
            make.left.equalTo(self).offset(11)
        }
        
        usernameLabel.snp_makeConstraints { (make) in
            make.top.equalTo(avatarImageView)
            make.left.equalTo(avatarImageView.snp_right).offset(6)
        }
        
        updatedTimeLabel.snp_makeConstraints { (make) in
            make.left.equalTo(usernameLabel)
            make.top.equalTo(usernameLabel.snp_bottom).offset(6)
        }
        
        moreButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(avatarImageView)
            make.right.equalTo(self).offset(-15)
        }
        
        
        liveImageView.snp_makeConstraints { (make) in
            make.top.equalTo(avatarImageView.snp_bottom).offset(11)
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(liveImageView.snp_width)
        }
        
        liveTagImageView.snp_makeConstraints { (make) in
            make.top.equalTo(liveImageView).offset(12)
            make.left.equalTo(liveImageView)
        }
        
        audienceCountLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(liveImageView).offset(-13)
            make.left.equalTo(liveImageView).offset(12)
        }
        
        coinsCountLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(audienceCountLabel)
            make.left.equalTo(audienceCountLabel.snp_right).offset(8)
        }
        
        liveDescLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(audienceCountLabel.snp_top).offset(-11)
            make.left.equalTo(audienceCountLabel)
        }
    }

    
    // MARK: public methods
    
    // MARK: private helpers
}
