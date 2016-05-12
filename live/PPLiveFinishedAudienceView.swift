//
//  PPLiveFinishedAudienceView.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/10.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPLiveFinishedAudienceView: UIView {
    
    private var liveEndedDescLabel: UILabel!
    
    private var liveFollowView: PPLiveFollowView!
    
    private var checkOtherLivesButton: UIButton!
    
    var checkOtherLivesClosure: (() -> Void)?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    convenience init(){
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: UI setup
    private func commonInit(){
        self.frame = UIScreen.mainScreen().bounds
        self.backgroundColor = UIColor(hex: 0x000000, alpha: 0.0)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PPLiveFinishedAudienceView.tapOnSelf(_:)))
        self.addGestureRecognizer(tap)
        
        
        // 关注 view
        liveFollowView       = PPLiveFollowView()

        liveFollowView.alpha = 0.0

        self.addSubview(liveFollowView)
        
        liveFollowView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 241, height: 296))
            
            make.centerX.equalTo(self)
            
            make.centerY.equalTo(self).offset(-10)
        }
        
        // 直播已结束 label
        
        liveEndedDescLabel = UILabel()
        
        liveEndedDescLabel.text = "直播已结束"
        
        liveEndedDescLabel.alpha = 0.0
        
        liveEndedDescLabel.textColor = UIColor.whiteColor()
        
        liveEndedDescLabel.font = UIFont.systemFontOfSize(16)
        
        self.addSubview(liveEndedDescLabel)
        
        liveEndedDescLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(liveFollowView.snp_top).offset(-18)
            make.centerX.equalTo(self)
        }
        
        // 看看别的直播 button
        
        checkOtherLivesButton = UIButton()
        
        checkOtherLivesButton.alpha = 0.0
        
        checkOtherLivesButton.setTitle("看看别的直播 >", forState: .Normal)
        checkOtherLivesButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        checkOtherLivesButton.titleLabel!.font = UIFont.systemFontOfSize(14)
        self.addSubview(checkOtherLivesButton)
        
        checkOtherLivesButton.snp_makeConstraints { (make) in
            make.top.equalTo(liveFollowView.snp_bottom).offset(35)
            make.centerX.equalTo(self)
        }
        
        checkOtherLivesButton.addTarget(self, action: #selector(PPLiveFinishedAudienceView.tapOnCheckOtherLivesButton), forControlEvents: .TouchUpInside)
    }
    
    // MARK: target-actions
    func tapOnSelf(recognizer: UITapGestureRecognizer){
        if self.hitTest(recognizer.locationInView(self), withEvent: nil) === self{
            dismiss()
            checkOtherLivesClosure?()
        }
    }
    
    func tapOnCheckOtherLivesButton(){
        checkOtherLivesClosure?()
    }
    
    // MARK: Public methods
    func show(){
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
        self.layoutIfNeeded()
        
        UIView.animateWithDuration(0.3) { 
            self.backgroundColor             = UIColor(hex: 0x000000, alpha: 0.8)
            self.liveFollowView.alpha        = 1.0
            self.liveEndedDescLabel.alpha    = 1.0
            self.checkOtherLivesButton.alpha = 1.0
        }
    }
    
    func showInView(view: UIView){
        view.addSubview(self)
        self.layoutIfNeeded()
        
        UIView.animateWithDuration(0.3) { 
            self.backgroundColor             = UIColor(hex: 0x000000, alpha: 0.8)
            self.liveFollowView.alpha        = 1.0
            self.liveEndedDescLabel.alpha    = 1.0
            self.checkOtherLivesButton.alpha = 1.0
        }
    }
    
    func dismiss(){
        UIView.animateWithDuration(0.3, animations: { 
            self.backgroundColor             = UIColor(hex: 0x000000, alpha: 0.0)
            self.liveFollowView.alpha        = 0.0
            self.liveEndedDescLabel.alpha    = 0.0
            self.checkOtherLivesButton.alpha = 0.0
            }) { (finished) in
                if finished{
                    self.removeFromSuperview()
                }
        }
    }
}
