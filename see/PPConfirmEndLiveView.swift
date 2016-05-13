//
//  PPConfirmEndLiveView.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/12.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPConfirmEndLiveView: UIView {

    var panelView: PPConfirmEndLivePanelView!
    
    var cancelDismissLiveClosure: (() -> Void)?
    
    var dismissLiveClosure: (() -> Void)?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    convenience init(){
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: UI setup
    private func setupSubviews(){
        self.frame           = UIScreen.mainScreen().bounds
        self.backgroundColor = UIColor(hex: 0x000000, alpha: 0.0)
        let tapOnSelf              = UITapGestureRecognizer(target: self, action: #selector(PPLiveFinishedStripperView.tapOnSelf(_:)))
        self.addGestureRecognizer(tapOnSelf)

        panelView = PPConfirmEndLivePanelView()
        panelView.alpha = 0.0
        self.addSubview(panelView)
        
        panelView.cancelButton.addTarget(self, action: #selector(PPConfirmEndLiveView.tapOnCancelButton), forControlEvents: .TouchUpInside)
        panelView.confirmButton.addTarget(self, action: #selector(PPConfirmEndLiveView.tapOnConfirmButton), forControlEvents: .TouchUpInside)
    }
    
    private func setupConstraints(){
        panelView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 200, height: 80))
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-80)
        }
    }
    
    // MARK: target-actions
    func tapOnSelf(recognizer: UITapGestureRecognizer){
        if self.hitTest(recognizer.locationInView(self), withEvent: nil) === self {
            dismiss()
        }
    }
    
    func tapOnCancelButton(){
        cancelDismissLiveClosure?()
    }
    
    func tapOnConfirmButton(){
        dismissLiveClosure?()
    }
    
    // MARK: Public methods
    func show(){
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
        
        self.layoutIfNeeded()
        
        UIView.animateWithDuration(0.3) {
            self.backgroundColor      = UIColor(hex: 0x000000, alpha: 0.8)
            self.panelView.alpha = 1.0
        }
    }
    
    func showInView(view: UIView){
        view.addSubview(self)
        
        self.layoutIfNeeded()
        
        UIView.animateWithDuration(0.3) {
            self.backgroundColor      = UIColor(hex: 0x000000, alpha: 0.8)
            self.panelView.alpha = 1.0
        }
    }
    
    func dismiss(){
        UIView.animateWithDuration(0.3, animations: {
            self.backgroundColor      = UIColor(hex: 0x000000, alpha: 0.0)
            self.panelView.alpha = 0.0
        }) { (finished) in
            if finished{
                self.removeFromSuperview()
            }
        }
    }

    
}
