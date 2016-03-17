//
//  PPSocialShareView.swift
//  live
//
//  Created by chenpeiwei on 3/17/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit
import SnapKit

class PPSocialShareView: UIView {
    
    var isShowing:Bool!
    
    var button1:PPLiveSocialShareButton!
    var button2:PPLiveSocialShareButton!
    var button3:PPLiveSocialShareButton!
    var button4:PPLiveSocialShareButton!
    var button5:PPLiveSocialShareButton!
    var triangleView:PPTriangleView!
    

    var widthConstraint:Constraint?
    var heightConstraint:Constraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        isShowing = false
        self.backgroundColor = UIColor.clearColor()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(inView view:UIView! ,relativeView:UIView!) {
        if isShowing == false {
            isShowing = true
            self.alpha = 1.0
            view .addSubview(self)
            widthConstraint = nil
            heightConstraint = nil
            
            self.snp_remakeConstraints { (make) -> Void in
                widthConstraint = make.width.equalTo(100).constraint
                heightConstraint = make.height.equalTo(200).constraint
                make.bottom.equalTo(relativeView.snp_top).offset(-20)
                make.centerX.equalTo(relativeView)
            }
            
            self.layoutIfNeeded()
            
//            widthConstraint?.updateOffset(100)
//            heightConstraint?.updateOffset(200)
            
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
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
    
    func setupViews() {
        button1 = styleButton("微博",imageName: "live-share-sinaweibo")
        button2 = styleButton("朋友圈",imageName:"live-share-wechatmoment")
        button3 = styleButton("微信",imageName:"live-share-wechat")
        button4 = styleButton("QQ",imageName:"live-share-qq")
        button5 = styleButton("QQ空间",imageName:"live-share-qzone")
        
        triangleView = PPTriangleView(strokeColor: UIColor.clearColor(), fillColor: UIColor(hex: 0x000000, alpha: 0.5))
        
        self.addSubview(button1)
        self.addSubview(button2)
        self.addSubview(button3)
        self.addSubview(button4)
        self.addSubview(button5)
        self.addSubview(triangleView)

        render()

    }
    
    func styleButton(title:String!,imageName:String!)->PPLiveSocialShareButton {
        let button = PPLiveSocialShareButton(type: .Custom)
        button .setTitle(title, forState: .Normal)
        button.setImage(UIImage(named: imageName), forState:.Normal)
        return button
    }
    
    func render() {
        button1.snp_makeConstraints { (make) -> Void in
            
            make.top.leading.trailing.equalTo(self)
            
            make.leading.equalTo(button2)
            make.leading.equalTo(button3)
            make.leading.equalTo(button4)
            make.leading.equalTo(button5)

            make.width.equalTo(button2)
            make.width.equalTo(button3)
            make.width.equalTo(button4)
            make.width.equalTo(button5)

            make.height.equalTo(button2)
            make.height.equalTo(button3)
            make.height.equalTo(button4)
            make.height.equalTo(button5)

        }
        
        button2.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(button1.snp_bottom)
        }
        
        button3.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(button2.snp_bottom)
        }
        button4.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(button3.snp_bottom)
        }

        button5.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(button4.snp_bottom)
            make.bottom.equalTo(self)

        }
        triangleView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_bottom).constraint
            make.centerX.equalTo(self)
            make.height.equalTo(10)
            make.width.equalTo(15)
        }
        
    }
    
    override func drawRect(rect: CGRect) {
//        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [ .TopLeft , .TopRight ] , cornerRadii: CGSize(width: 10.0, height: 10.0))
//        let maskLayer = CAShapeLayer()
//        maskLayer.frame = CGRectMake(0, 0, 100, 50)
//        maskLayer.path = path.CGPath
//        self.layer.mask = maskLayer
        
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds
//            byRoundingCorners:UIRectCornerTopLeft| UIRectCornerTopRight
//            cornerRadii:CGSizeMake(10.0, 10.0)];
//        // Create the shape layer and set its path
//        CAShapeLayer *maskLayer = [CAShapeLayer layer];
//        maskLayer.frame = imageView.bounds;
//        maskLayer.path = maskPath.CGPath;
        // Set the newly created shape layer as the mask for the image view's layer
    }

}
