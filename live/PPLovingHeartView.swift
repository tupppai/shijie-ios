//
//  PPLovingHeartView.swift
//  live
//
//  Created by chenpeiwei on 3/16/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit


class PPLovingHeartView: SpringView {
    
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.clearColor()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct HeartColor {
        static let lightPurple = UIColor(hex: 0xe2d2f6)
        static let lightBlue = UIColor(hex: 0xe0ffff)
        static let goodGreen = UIColor(hex: 0x59dfac)
        static let lightPink = UIColor(hex: 0xe2d2f6)
        static let jollyPink = UIColor(hex: 0xffcacb)
        static let goodPink = UIColor(hex: 0xd82e84)
    }

    
    override func drawRect(rect: CGRect) {
        //// Color Declarations
                 // framesize (20,19)
        let fillColor = generateRandomColor()
        
        let fillColor2 = UIColor.whiteColor()
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(4.76, 0.34))
        bezierPath.addCurveToPoint(CGPointMake(0.17, 6.48), controlPoint1: CGPointMake(2.18, 1.16), controlPoint2: CGPointMake(0.17, 3.85))
        bezierPath.addCurveToPoint(CGPointMake(1.76, 10.72), controlPoint1: CGPointMake(0.19, 7.61), controlPoint2: CGPointMake(0.81, 9.29))
        bezierPath.addCurveToPoint(CGPointMake(5.78, 15.14), controlPoint1: CGPointMake(2.12, 11.3), controlPoint2: CGPointMake(3.94, 13.27))
        bezierPath.addCurveToPoint(CGPointMake(9.65, 19.51), controlPoint1: CGPointMake(7.65, 17.04), controlPoint2: CGPointMake(9.35, 18.95))
        bezierPath.addLineToPoint(CGPointMake(10.19, 20.49))
        bezierPath.addLineToPoint(CGPointMake(10.59, 19.61))
        bezierPath.addCurveToPoint(CGPointMake(14.34, 15.34), controlPoint1: CGPointMake(10.85, 19.03), controlPoint2: CGPointMake(12.19, 17.52))
        bezierPath.addCurveToPoint(CGPointMake(19.56, 8.88), controlPoint1: CGPointMake(18.12, 11.5), controlPoint2: CGPointMake(18.7, 10.81))
        bezierPath.addCurveToPoint(CGPointMake(20.1, 6.13), controlPoint1: CGPointMake(20.12, 7.67), controlPoint2: CGPointMake(20.18, 7.36))
        bezierPath.addCurveToPoint(CGPointMake(12.45, 0.55), controlPoint1: CGPointMake(19.82, 2.09), controlPoint2: CGPointMake(15.64, -0.95))
        bezierPath.addCurveToPoint(CGPointMake(10.91, 1.76), controlPoint1: CGPointMake(12.01, 0.75), controlPoint2: CGPointMake(11.31, 1.31))
        bezierPath.addLineToPoint(CGPointMake(10.15, 2.62))
        bezierPath.addLineToPoint(CGPointMake(9.41, 1.76))
        bezierPath.addCurveToPoint(CGPointMake(4.76, 0.34), controlPoint1: CGPointMake(8.17, 0.38), controlPoint2: CGPointMake(6.4, -0.17))
        bezierPath.closePath()
        fillColor.setFill()
        bezierPath.fill()
        
        bezierPath.moveToPoint(CGPointMake(8.01, 1.26))
        bezierPath.addCurveToPoint(CGPointMake(9.81, 2.84), controlPoint1: CGPointMake(8.69, 1.55), controlPoint2: CGPointMake(9.33, 2.11))
        bezierPath.addCurveToPoint(CGPointMake(10.89, 2.39), controlPoint1: CGPointMake(10.11, 3.28), controlPoint2: CGPointMake(10.13, 3.28))
        bezierPath.addCurveToPoint(CGPointMake(14.01, 0.98), controlPoint1: CGPointMake(11.83, 1.33), controlPoint2: CGPointMake(12.61, 0.98))
        bezierPath.addCurveToPoint(CGPointMake(18.12, 3.13), controlPoint1: CGPointMake(15.5, 0.98), controlPoint2: CGPointMake(17.24, 1.88))
        bezierPath.addCurveToPoint(CGPointMake(19.34, 6.78), controlPoint1: CGPointMake(19.06, 4.47), controlPoint2: CGPointMake(19.34, 5.33))
        bezierPath.addCurveToPoint(CGPointMake(14.44, 14.52), controlPoint1: CGPointMake(19.34, 9.04), controlPoint2: CGPointMake(18.68, 10.09))
        bezierPath.addCurveToPoint(CGPointMake(10.57, 18.99), controlPoint1: CGPointMake(12.45, 16.61), controlPoint2: CGPointMake(10.71, 18.62))
        bezierPath.addCurveToPoint(CGPointMake(10.17, 19.65), controlPoint1: CGPointMake(10.43, 19.34), controlPoint2: CGPointMake(10.25, 19.65))
        bezierPath.addCurveToPoint(CGPointMake(9.77, 18.97), controlPoint1: CGPointMake(10.11, 19.65), controlPoint2: CGPointMake(9.91, 19.34))
        bezierPath.addCurveToPoint(CGPointMake(5.86, 14.52), controlPoint1: CGPointMake(9.61, 18.62), controlPoint2: CGPointMake(7.85, 16.61))
        bezierPath.addCurveToPoint(CGPointMake(0.97, 6.74), controlPoint1: CGPointMake(1.6, 10.07), controlPoint2: CGPointMake(0.97, 9.04))
        bezierPath.addCurveToPoint(CGPointMake(2.5, 2.82), controlPoint1: CGPointMake(0.97, 5.14), controlPoint2: CGPointMake(1.38, 4.08))
        bezierPath.addCurveToPoint(CGPointMake(8.01, 1.26), controlPoint1: CGPointMake(3.9, 1.2), controlPoint2: CGPointMake(6.34, 0.53))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;
        
        fillColor2.setFill()
        bezierPath.fill()

    }
    
    func generateRandomColor()->UIColor {
        
        var color:UIColor?
        let diceRoll = Int(arc4random_uniform(6) + 1)
        switch(diceRoll) {
            
//            ffcacb
        case 1: color = HeartColor.lightPurple
        case 2: color = HeartColor.lightBlue

        case 3: color = HeartColor.goodGreen

        case 4: color = HeartColor.lightPink

        case 5: color = HeartColor.jollyPink

        case 6: color = HeartColor.goodPink
        default: color = HeartColor.goodPink
        }
        return color!
    }
}
