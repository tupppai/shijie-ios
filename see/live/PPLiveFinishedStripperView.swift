//
//  PPLiveFinishedStripperView.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/10.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPLiveFinishedStripperView: UIView {
    private var statisticsView: PPLiveStatisticsView!
    
    private var liveShareView: PPLiveShareView!
    
    var goHomeClosure: (() -> Void)?
    
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(PPLiveFinishedStripperView.tapOnSelf(_:)))
        self.addGestureRecognizer(tap)
        
        statisticsView = PPLiveStatisticsView()
        
        statisticsView.alpha = 0.0
        
        self.addSubview(statisticsView)
        
        statisticsView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 250, height: 280))
            make.top.equalTo(self).offset(60)
            make.centerX.equalTo(self)
        }
        
        liveShareView = PPLiveShareView()
        
        liveShareView.alpha = 0.0
        
        liveShareView.goBackHomeButton.addTarget(self, action: #selector(PPLiveFinishedStripperView.tapOnGoHomeButton), forControlEvents: .TouchUpInside)
        
        self.addSubview(liveShareView)
        
        liveShareView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.width.equalTo(222)
            make.top.equalTo(statisticsView.snp_bottom).offset(38)
            make.height.equalTo(120)
        }
        
    }
    
    // MARK: target-actions
    func tapOnSelf(recognizer: UITapGestureRecognizer){
        if self.hitTest(recognizer.locationInView(self), withEvent: nil) === self {
            dismiss()
            // 不知道要不要做到这一步
            goHomeClosure?()
        }
    }
    
    func tapOnGoHomeButton(){
        goHomeClosure?()
    }
    
    // MARK: Public methods
    func show(){
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
        
        self.layoutIfNeeded()
        
        UIView.animateWithDuration(0.3) { 
            self.backgroundColor      = UIColor(hex: 0x000000, alpha: 0.8)
            self.statisticsView.alpha = 1.0
            self.liveShareView.alpha  = 1.0
        }
    }
    
    func showInView(view: UIView){
        view.addSubview(self)
        
        self.layoutIfNeeded()
        
        UIView.animateWithDuration(0.3) { 
            self.backgroundColor      = UIColor(hex: 0x000000, alpha: 0.8)
            self.statisticsView.alpha = 1.0
            self.liveShareView.alpha  = 1.0
        }
    }
    
    func dismiss(){
        UIView.animateWithDuration(0.3, animations: { 
            self.backgroundColor      = UIColor(hex: 0x000000, alpha: 0.0)
            self.statisticsView.alpha = 0.0
            self.liveShareView.alpha  = 0.0
            
            }) { (finished) in
                if finished{
                    self.removeFromSuperview()
                }
        }
    }
}
