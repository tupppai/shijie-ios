//
//  PPTriangleView.swift
//  live
//
//  Created by chenpeiwei on 3/17/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPTriangleView: UIView {
    
    var strokeColor = UIColor.lightGrayColor()
    var fillColor = UIColor.lightGrayColor()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
    }
    
    convenience init(strokeColor:UIColor?,fillColor:UIColor?) {
        self.init()
        if let strokeColor = strokeColor {
            self.strokeColor = strokeColor
        }
        if let fillColor = fillColor {
            self.fillColor = fillColor
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        let size = rect.size
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(0, 0))
        bezier2Path.addLineToPoint(CGPointMake(size.width*0.5, size.height))
        bezier2Path.addLineToPoint(CGPointMake(size.width, 0))
        strokeColor.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        fillColor.setFill()
        bezier2Path.fill()
    }
}
