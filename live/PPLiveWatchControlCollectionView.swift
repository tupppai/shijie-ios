//
//  PPLiveWatchControlCollectionView.swift
//  live
//
//  Created by chenpeiwei on 3/16/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

protocol PPLiveWatchControlCollectionViewDelegate: class {
    func controlCollectionView(controlCollectionView: PPLiveWatchControlCollectionView, didTapIndex index: Int)
}

class PPLiveWatchControlCollectionView: UIView {
    private var button_comment:UIButton!
    var button_share:UIButton!
    private var button_close:UIButton!
    var button_sendGift:UIButton!

    weak var delegate: PPLiveWatchControlCollectionViewDelegate? = nil

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        button_comment = UIButton(type: .Custom)
        button_share = UIButton(type: .Custom)
        button_sendGift = UIButton(type: .Custom)
        button_close = UIButton(type: .Custom)
        button_comment .setImage(UIImage(named: "live-comment"), forState: .Normal)
        button_share .setImage(UIImage(named: "live-share"), forState: .Normal)
        button_sendGift .setImage(UIImage(named: "live-sendgift"), forState: .Normal)
        button_close .setImage(UIImage(named: "live-close"), forState: .Normal)
        
        
        button_close .addTarget(self, action: "tapButton_close", forControlEvents: .TouchUpInside)
        button_sendGift .addTarget(self, action: "tapButton_sendGift", forControlEvents: .TouchUpInside)
        button_comment .addTarget(self, action: "tapButton_comment", forControlEvents: .TouchUpInside)
        button_share .addTarget(self, action: "tapButton_share", forControlEvents: .TouchUpInside)
        
        self .addSubview(button_comment)
        self .addSubview(button_share)
        self .addSubview(button_sendGift)
        self .addSubview(button_close)
        
        button_comment.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(34)
            make.leading.equalTo(self).offset(12)
            make.bottom.equalTo(self).offset(-12)
        }
        
        button_close.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(34)
            make.trailing.equalTo(self).offset(-12)
            make.bottom.equalTo(self).offset(-12)
        }
        button_sendGift.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(34)
            make.trailing.equalTo(button_close.snp_leading).offset(-15)
            make.bottom.equalTo(self).offset(-12)
        }
        
        button_share.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(34)
            make.trailing.equalTo(button_sendGift.snp_leading).offset(-15)
            make.bottom.equalTo(self).offset(-12)
        }
    }
    
    func tapButton_close() {
        delegate?.controlCollectionView(self, didTapIndex: 3)
    }
    func tapButton_sendGift() {
        delegate?.controlCollectionView(self, didTapIndex: 2)
    }
    func tapButton_comment() {
        delegate?.controlCollectionView(self, didTapIndex: 0)
    }
    func tapButton_share() {
        delegate?.controlCollectionView(self, didTapIndex: 1)
    }
    
}
