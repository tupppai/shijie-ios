//
//  PPShareView.swift
//  live
//
//  Created by chenpeiwei on 3/17/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit
import SnapKit
class PPShareView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isShowing = false
        self.backgroundColor = UIColor.clearColor()
        setupViews()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var shareSheetView:PPShareSheetView!

    var triangleView:PPTriangleView!
    var widthConstraint:Constraint?
    var heightConstraint:Constraint?
    
    var isShowing:Bool!

    func setupViews() {
        
        shareSheetView = PPShareSheetView()
        triangleView = PPTriangleView(strokeColor: UIColor.clearColor(), fillColor: UIColor(hex: 0x000000, alpha: 0.7))
        
        self.addSubview(shareSheetView)
        self.addSubview(triangleView)
        
        render()
        
    }
    
    func render () {
        shareSheetView.snp_makeConstraints { (make) -> Void in
            make.top.leading.trailing.equalTo(self)
        }
        triangleView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(shareSheetView.snp_bottom)
            make.bottom.equalTo(self)
            make.centerX.equalTo(self)
            make.height.equalTo(10).priorityMedium()
            make.width.equalTo(15).priorityMedium()
        }
    }
    
    func show(inView view:UIView! ,relativeView:UIView!) {
        if isShowing == false {
            isShowing = true
            self.alpha = 1.0
            view .addSubview(self)
            widthConstraint = nil
            heightConstraint = nil
            
            self.snp_remakeConstraints { (make) -> Void in
                widthConstraint = make.width.equalTo(0).constraint
                heightConstraint = make.height.equalTo(0).constraint
                make.bottom.equalTo(relativeView.snp_top).offset(-20)
                make.centerX.equalTo(relativeView)
            }
            
            self.layoutIfNeeded()
            
            widthConstraint?.updateOffset(120)
            heightConstraint?.updateOffset(240)
            
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.layoutIfNeeded()
                }, completion: { (finished) -> Void in}
            )
        }
    }
    
    func dismiss() {
        if isShowing == true {
            isShowing = false
            widthConstraint?.updateOffset(0)
            heightConstraint?.updateOffset(0)
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.alpha = 0
                self.layoutIfNeeded()
                }, completion: { (finished) -> Void in
                    self .removeFromSuperview()
                }
            )
        }
    }

    
    
}
