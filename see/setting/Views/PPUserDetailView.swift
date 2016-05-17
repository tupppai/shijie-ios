//
//  PPUserDetailView.swift
//  vision_demo
//
//  Created by TUPAI-Huangwei on 3/16/16.
//  Copyright © 2016 TUPAI-Huangwei. All rights reserved.
//

import UIKit
import SnapKit

enum PPUserDetailViewButtonType{
    case Follow
    case PrivateMessage
    case Reply
    case HomePage
}

class PPUserDetailView: UIView {

    private var panelView: PPUserPanelView?

    private var dismissButton: UIButton?
    
    var buttonActionClosure: (PPUserDetailViewButtonType -> Void)?
    
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
        let tap = UITapGestureRecognizer(target: self, action: Selector("tapOnSelf:"))
        self.addGestureRecognizer(tap)
        
        setupSubviews()
        setupTargetAction()
    }
    
    private func setupSubviews(){
        panelView = PPUserPanelView()
        panelView?.alpha = 0.0
        self.addSubview(panelView!)
        panelView?.snp_makeConstraints(closure: { (make) -> Void in
            make.height.equalTo(325)
            make.width.equalTo(280)
            make.center.equalTo(self)
        })
        
        dismissButton = UIButton()
        self.dismissButton?.setImage(UIImage(named: "btn_close"),
                                     forState:.Normal)
        self.dismissButton?.addTarget(self, action: "dismiss", forControlEvents: .TouchUpInside)
        self.dismissButton?.alpha = 0.0
        self.addSubview(self.dismissButton!)
        dismissButton?.snp_makeConstraints(closure: {(make) -> Void in
            make.size.equalTo(CGSizeMake(34, 34))
            //            make.top.trailing.equalTo(panelView!).offset(34)
            make.top.equalTo(panelView!).offset(34)
            make.trailing.equalTo(panelView!).offset(-2)
        })
    }
    
    private func setupTargetAction(){
        panelView?.userDetailPanelView.followButton.addTarget(self, action: #selector(PPUserDetailView.tapOnFollowButton(_:)), forControlEvents: .TouchUpInside)
        panelView?.userDetailPanelView.replyButton.addTarget(self, action: #selector(PPUserDetailView.tapOnReplyButton(_:)), forControlEvents: .TouchUpInside)
        panelView?.userDetailPanelView.privateMessageButton.addTarget(self, action: #selector(PPUserDetailView.tapOnPrivateMessageButton(_:)), forControlEvents: .TouchUpInside)
        panelView?.userDetailPanelView.homepageButton.addTarget(self, action: #selector(PPUserDetailView.tapOnHomepageButton(_:)), forControlEvents: .TouchUpInside)
    }
    
    
    // MARK: Public methods
    func show(){
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
        self.layoutIfNeeded()

        UIView.animateWithDuration(0.3) { () -> Void in
            self.backgroundColor       = UIColor(hex: 0x000000, alpha: 0.8)
            self.panelView?.alpha      = 1.0
            self.dismissButton?.alpha  = 1.0
        }
    }
    
    func showInView(view:UIView!) {
        view.addSubview(self)
        UIView.animateWithDuration(0.3) { () -> Void in
            self.backgroundColor       = UIColor(hex: 0x000000, alpha: 0.1)
            self.panelView?.alpha      = 1.0
            self.dismissButton?.alpha  = 0.4
        }
        self.panelView?.slideUpAnimate()
    }
    
    func dismiss(){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.backgroundColor       = UIColor(hex: 0x000000, alpha: 0.0)
                self.panelView?.alpha      = 0.0
                self.dismissButton?.alpha  = 0.0
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
    
    func tapOnFollowButton(recognizer: UITapGestureRecognizer){
        buttonActionClosure?(.Follow)
    }
    
    func tapOnPrivateMessageButton(recognizer: UITapGestureRecognizer){
        buttonActionClosure?(.PrivateMessage)
    }
    
    func tapOnReplyButton(recognizer: UITapGestureRecognizer){
        buttonActionClosure?(.Reply)
    }
    
    func tapOnHomepageButton(recognizer: UITapGestureRecognizer){
        buttonActionClosure?(.HomePage)
    }
}
