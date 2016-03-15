//
//  PPLiveTableViewCell.swift
//  live
//
//  Created by chenpeiwei on 3/15/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit
import SnapKit

class PPLiveTableViewCell: UITableViewCell {
    
    var avatarButton:UIButton!
    var usernameButton:UIButton!
    var timeLabel:UILabel!
    var watchingCountLabel:UILabel!
    var watchingCountSuffixLabel:UILabel!
    var preViewImageView:UIImageView!
    var broadcastIndicatorImageView:UIImageView!
    var gapView:UIView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        self.setupSubviews()
        self.render()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupSubviews() {
        

        avatarButton = UIButton(type: .Custom)

        usernameButton = UIButton(type: .Custom)
        usernameButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        usernameButton .setTitle("hellowhat'goo'sup", forState: .Normal)

        
        timeLabel = UILabel()
        timeLabel.text = "两分钟前"
        timeLabel.textColor = UIColor(hex: 0x000000)

        watchingCountLabel = UILabel()
        watchingCountLabel.textColor = UIColor(red: 60/255.0, green: 215/255.0, blue: 195/255.0, alpha: 1.0)
        watchingCountLabel.text = "122223"
        watchingCountLabel.textAlignment = .Right
        
        watchingCountSuffixLabel = UILabel()
        watchingCountSuffixLabel.text = "在看"
        
        preViewImageView = UIImageView()
        preViewImageView.image = UIImage(named: "demo")
        broadcastIndicatorImageView = UIImageView()
        
        gapView = UIView()
        
        avatarButton .backgroundColor = UIColor(hex: 0x668b8b)
        usernameButton.backgroundColor = UIColor.whiteColor()
        timeLabel.backgroundColor = UIColor.whiteColor()
        watchingCountSuffixLabel.backgroundColor = UIColor.whiteColor()
        watchingCountLabel.backgroundColor = UIColor.whiteColor()
        preViewImageView.backgroundColor = UIColor(hex: 0xffefdb)
        gapView.backgroundColor = UIColor(hex: 0xf4f4f4)
        
        
            if #available(iOS 8.2, *) {
                usernameButton.titleLabel?.font = UIFont.systemFontOfSize(13, weight: UIFontWeightRegular)
                timeLabel.font =  UIFont.systemFontOfSize(10, weight: UIFontWeightLight)
                watchingCountLabel.font = UIFont.systemFontOfSize(15, weight: UIFontWeightRegular)
                watchingCountSuffixLabel.font =  UIFont.systemFontOfSize(12, weight: UIFontWeightLight)
            } else {
                usernameButton.titleLabel?.font = UIFont.boldSystemFontOfSize(13)
                timeLabel.font =  UIFont.systemFontOfSize(10)
                watchingCountLabel.font = UIFont.boldSystemFontOfSize(15)
                watchingCountSuffixLabel.font =  UIFont.systemFontOfSize(12)
        }
   


        contentView .addSubview(avatarButton)
        contentView .addSubview(usernameButton)
        contentView .addSubview(timeLabel)
        contentView .addSubview(watchingCountLabel)
        contentView .addSubview(watchingCountSuffixLabel)
        contentView .addSubview(preViewImageView)
        contentView .addSubview(broadcastIndicatorImageView)
        contentView .addSubview(gapView)

    }
    private func render() {
        //cell height = 11+32+11+screenWidth
        avatarButton.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(32)
            make.height.equalTo(32)
            make.leading.equalTo(contentView).offset(11)
            make.top.equalTo(contentView).offset(11)
        }
        
        usernameButton.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(19)
            make.leading.equalTo(avatarButton.snp_trailing).offset(7)
            make.top.equalTo(avatarButton).offset(-2)
        }
        timeLabel.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(usernameButton)
            make.top.equalTo(usernameButton.snp_bottom).offset(1)
        }
        watchingCountSuffixLabel.snp_makeConstraints { (make) -> Void in
            make.trailing.equalTo(contentView.snp_trailing).offset(-11)
            make.centerY.equalTo(usernameButton)
        }
        watchingCountLabel.snp_makeConstraints { (make) -> Void in
            make.trailing.equalTo(watchingCountSuffixLabel.snp_leading).priorityRequired()
            make.centerY.equalTo(watchingCountSuffixLabel)
            make.leading.equalTo(usernameButton.snp_trailing).priorityLow()
            make.leading.equalTo(timeLabel.snp_trailing).priorityLow()
        }
        preViewImageView.snp_makeConstraints { (make) -> Void in
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(avatarButton.snp_bottom).offset(11)
            make.height.equalTo(preViewImageView.snp_width)
        }
        gapView.snp_makeConstraints { (make) -> Void in
            make.bottom.leading.trailing.equalTo(contentView)
            make.top.equalTo(preViewImageView.snp_bottom)
        }

    }
    
    func injectSource() {
        usernameButton .setTitle("hellowhat''sup", forState: .Normal)
        timeLabel.text = "两分钟前"
        watchingCountLabel.text = "122223"
        

    }
    override func layoutSubviews() {
        avatarButton.layer.cornerRadius = 16
        avatarButton.clipsToBounds = true
        super.layoutSubviews()
    }
}
