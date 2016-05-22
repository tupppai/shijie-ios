//
//  PPFakeNavigationBar.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/18.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

protocol PPFakeNaivgationBarDelegate: class{
    func fakeNavigationBar(navBar: PPFakeNavigationBar,
                           didTapButton buttonType: PPFakeNavigationBarButtonType)
}

enum PPFakeNavigationBarButtonType {
    case Back
    case OnLive
    case More
}

class PPFakeNavigationBar: UIView {
    
    weak var delegate : PPFakeNaivgationBarDelegate?
    
    var segueBackButton: UIButton!
    
    var onLiveStatusIndicatorButton: UIButton!
    
    var moreButton: UIButton!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
        setupTargetActions()
    }
    
    convenience init(){
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
        setupConstraints()
        setupTargetActions()
    }
    
    // MARK: UI setup
    private func setupSubviews(){
        self.backgroundColor = UIColor.whiteColor()
        
        // --- 返回 按钮
        segueBackButton = UIButton()
        segueBackButton.setImage(UIImage(named: "ic_back_black"), forState: .Normal)
        segueBackButton.imageView?.contentMode = .Center
        self.addSubview(segueBackButton)
        
        // --- "正在直播" 按钮
        onLiveStatusIndicatorButton = UIButton()
        onLiveStatusIndicatorButton.setBackgroundImage(UIImage(named: "btn_orange_small_20pxH"), forState: .Normal)
        onLiveStatusIndicatorButton.setTitle("正在直播", forState: .Normal)
        onLiveStatusIndicatorButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        onLiveStatusIndicatorButton.titleLabel?.font = UIFont.systemFontOfSize(10)
        self.addSubview(onLiveStatusIndicatorButton)
        
        // --- "更多" 按钮
        moreButton = UIButton()
        moreButton.setImage(UIImage(named: "icon_more"), forState: .Normal)
        moreButton.contentMode = .Center
        self.addSubview(moreButton)
    }
    
    private func setupConstraints(){
        segueBackButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(self).offset(12)
            make.width.equalTo(segueBackButton.snp_height)
        }
        
        moreButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.right.equalTo(self).offset(-12)
            make.width.equalTo(moreButton.snp_height)
        }
        
        onLiveStatusIndicatorButton.snp_makeConstraints { (make) in
            make.right.equalTo(moreButton.snp_left).offset(-16)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 60, height: 20))
        }
        
    }
    
    private func setupTargetActions(){
        segueBackButton.addTarget(self, action: #selector(self.tapBackButton), forControlEvents: .TouchUpInside)
        onLiveStatusIndicatorButton.addTarget(self, action: #selector(self.tapOnLiveButton), forControlEvents: .TouchUpInside)
        moreButton.addTarget(self, action: #selector(self.tapOnMoreButton), forControlEvents: .TouchUpInside)
    }
    
    // MARK: Target-actions
    func tapBackButton(){
        delegate?.fakeNavigationBar(self, didTapButton: .Back)
    }
    
    func tapOnLiveButton(){
        delegate?.fakeNavigationBar(self, didTapButton: .OnLive)
    }
    
    func tapOnMoreButton(){
        delegate?.fakeNavigationBar(self, didTapButton: .More)
    }

}
