//
//  PPLiveSocialShareButton.swift
//  live
//
//  Created by chenpeiwei on 3/17/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPLiveSocialShareButton: UIButton {
    
    var clipBottom:Bool = false
    var clipTop:Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.font = UIFont.systemFontOfSize(15)
        self.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        self.contentHorizontalAlignment = .Left
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
//        self.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0)
        self.titleLabel?.textAlignment = .Left
        self.backgroundColor = UIColor(hex: 0x000000, alpha: 0.7)
//        self.imageView?.snp_makeConstraints(closure: { (make) -> Void in
//            make.top.bottom.equalTo(self)
//            make.leading.equalTo(self).offset(8)
//            make.width.equalTo((self.imageView?.snp_height)!).priorityMedium()
////            make.trailing.equalTo((self.titleLabel?.snp_leading)!).offset(-6)
//        })
//        self.titleLabel?.snp_makeConstraints(closure: { (make) -> Void in
//            make.leading.equalTo((self.imageView?.snp_trailing)!).offset(6)
//            make.trailing.equalTo(self).priorityMedium()
//            make.centerY.equalTo(self).priorityMedium()
//        })
        

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var frame1 = self.titleLabel?.frame
        frame1?.origin.x = self.frame.size.width*0.5-15
        self.titleLabel?.frame = frame1!
    }
    override func drawRect(rect: CGRect) {
//        var clipArray:OptionSetType
//        if clipTop {
//            clipArray.insert(UIRectCorner.TopLeft)
//            clipArray.insert(UIRectCorner.TopRight)
//        }
//        if clipBottom {
//            clipArray.insert(UIRectCorner.BottomLeft)
//            clipArray.insert(UIRectCorner.BottomRight)
//        }
//                let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [ .TopLeft , .TopRight ] , cornerRadii: CGSize(width: 10.0, height: 10.0))
//                let maskLayer = CAShapeLayer()
//                maskLayer.frame = rect
//                maskLayer.path = path.CGPath
//                self.layer.mask = maskLayer
//    }
}
