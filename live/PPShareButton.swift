//
//  PPShareButton.swift
//  live
//
//  Created by chenpeiwei on 3/17/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit
import SnapKit

class PPShareButton: UIButton {
    
    var clipBottom:Bool = false
    var clipTop:Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.font = UIFont.systemFontOfSize(15)
        self.setTitleColor(UIColor(hex: 0x59dfac), forState: .Highlighted)

        self.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        self.contentHorizontalAlignment = .Left
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        self.titleLabel?.textAlignment = .Left
        
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
        
        if clipBottom == false && clipTop == false {
            return
        }
        
        var path:UIBezierPath!

        if clipTop {
            path = UIBezierPath(roundedRect: rect, byRoundingCorners: [ .TopLeft , .TopRight ] , cornerRadii: CGSize(width: 10.0, height: 10.0))
        }
        if clipBottom {
            path = UIBezierPath(roundedRect: rect, byRoundingCorners: [ .BottomLeft , .BottomRight ] , cornerRadii: CGSize(width: 10.0, height: 10.0))

        }
        

                UIView .animateWithDuration(1.5) { () -> Void in
                    let maskLayer = CAShapeLayer()
                    maskLayer.frame = rect
                    maskLayer.path = path.CGPath
                    self.layer.mask = maskLayer

        }
    }
}
