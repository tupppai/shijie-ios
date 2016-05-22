//
//  PPVIPCommitSuccessView.swift
//  see
//
//  Created by TUPAI-Huangwei on 16/5/20.
//  Copyright © 2016年 pires.inc. All rights reserved.
//

import UIKit

class PPVIPCommitSuccessView: UIView {

    var panelView: PPVIPCommitSuccessPanelView!
    
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

    private func commonInit(){
        self.frame = UIScreen.mainScreen().bounds
        self.backgroundColor = UIColor(hex: 0x000000, alpha: 0.0)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapOnSelf(_:)))
        self.addGestureRecognizer(tap)
        
        setupSubviews()
    }
    
    private func setupSubviews(){
        panelView = PPVIPCommitSuccessPanelView()
        panelView.alpha = 0.0
        
        panelView.okButton.addTarget(self, action: #selector(self.dismiss), forControlEvents: .TouchUpInside)
        
        self.addSubview(panelView)
        
        panelView.snp_makeConstraints { (make) in
            make.width.equalTo(self).multipliedBy(654.0 / 750)
            make.height.equalTo(panelView.snp_width).multipliedBy(500.0 / 654.0)
            make.centerX.equalTo(self)
            make.bottom.equalTo(self.snp_centerY).offset(30)
        }
    }
    
    
    // MARK: Public methods
    func show(){
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
        self.layoutIfNeeded()
        
        UIView.animateWithDuration(0.3) { () -> Void in
            self.backgroundColor       = UIColor(hex: 0x000000, alpha: 0.8)
            self.panelView?.alpha      = 1.0
        }
    }
    
    func showInView(view:UIView!) {
        view.addSubview(self)
        UIView.animateWithDuration(0.3) { () -> Void in
            self.backgroundColor       = UIColor(hex: 0x000000, alpha: 0.1)
            self.panelView?.alpha      = 1.0
        }
        
    }
    
    func dismiss(){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.backgroundColor       = UIColor(hex: 0x000000, alpha: 0.0)
            self.panelView?.alpha      = 0.0
        }) { (finished) -> Void in
            if finished{
                self.removeFromSuperview()
            }
        }
    }
    
    // MARK: target-actions
    func tapOnSelf(recognizer: UITapGestureRecognizer){
        if self.hitTest(recognizer.locationInView(self), withEvent: nil) === self{
            dismiss()
        }
    }
}
