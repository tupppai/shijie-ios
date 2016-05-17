//
//  PPFriendBroadcastCollectionViewCell.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/16.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPFriendBroadcastCollectionViewCell: UICollectionViewCell {
    
    private var onLiveTag: UIImageView!
    
    private var broadcastImageView: UIImageView!
    
    private var audienceCountLabel: UILabel!
    
    private var bottomShadowImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: UI setup
    private func commonInit(){
        broadcastImageView = UIImageView(image: UIImage(named: "liveImage_small"))
        broadcastImageView.contentMode = .ScaleToFill
        self.contentView.addSubview(broadcastImageView)
        
        onLiveTag = UIImageView(image: UIImage(named: "tag_onLive"))
        self.contentView.addSubview(onLiveTag)
        
        bottomShadowImageView = UIImageView(image: UIImage(named: "button_shadow"))
        bottomShadowImageView.contentMode = .ScaleToFill
        self.contentView.addSubview(bottomShadowImageView)
        
        audienceCountLabel = UILabel()
        audienceCountLabel.text = "22 观众"
        audienceCountLabel.textColor = UIColor.whiteColor()
        audienceCountLabel.textAlignment = .Right
        audienceCountLabel.font = UIFont.systemFontOfSize(10)
        self.contentView.addSubview(audienceCountLabel)
        
        // --- add constraints
        broadcastImageView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        
        onLiveTag.snp_makeConstraints { (make) in
            make.left.equalTo(self.contentView)
            make.top.equalTo(self.contentView).offset(9)
        }
        
        bottomShadowImageView.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(self.contentView)
            make.height.equalTo(25)
        }
        
        audienceCountLabel.snp_makeConstraints { (make) in
            make.bottom.right.equalTo(self.contentView)
        }
    }
}
