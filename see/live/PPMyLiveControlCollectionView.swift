//
//  PPLiveingControlCollectionView.swift
//  live
//
//  Created by chenpeiwei on 3/22/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit


protocol PPMyLiveControlCollectionViewDelegate: class {
    func myLiveControlCollectionView(myliveControlCollectionView: PPMyLiveControlCollectionView, didTapIndex index: Int)
}


class PPMyLiveControlCollectionView: UIView {
    private var button_comment:UIButton!
    private var button_close:UIButton!
    var button_camera:UIButton!
    
    weak var delegate: PPMyLiveControlCollectionViewDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        
        button_comment = UIButton(type: .Custom)
        button_camera = UIButton(type: .Custom)
        
        
        
        button_close = UIButton(type: .Custom)
        button_comment .setImage(UIImage(named: "live-comment"), forState: .Normal)
        button_camera .setImage(UIImage(named: "live-sendgift"), forState: .Normal)
        button_close .setImage(UIImage(named: "live-close"), forState: .Normal)
        
        
        button_close .addTarget(self, action: "tapButton_close", forControlEvents: UIControlEvents.TouchDown)
        button_camera .addTarget(self, action: "tapButton_camera", forControlEvents: .TouchDown)
        button_comment .addTarget(self, action: "tapButton_comment", forControlEvents: .TouchDown)
        
        self .addSubview(button_comment)
        self .addSubview(button_camera)
        self .addSubview(button_close)
        
        button_comment.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(34)
            make.leading.equalTo(self).offset(12)
            make.centerY.equalTo(self)
        }
        
        button_close.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(34)
            make.trailing.equalTo(self).offset(-12)
            make.centerY.equalTo(self)
        }
        button_camera.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(34)
            make.trailing.equalTo(button_close.snp_leading).offset(-15)
            make.centerY.equalTo(self)
        }
      
    }
    
    func tapButton_close() {
        delegate?.myLiveControlCollectionView(self, didTapIndex: 2)
    }
    func tapButton_camera() {
        delegate?.myLiveControlCollectionView(self, didTapIndex: 1)
    }
    func tapButton_comment() {
        delegate?.myLiveControlCollectionView(self, didTapIndex: 0)
    }


}
