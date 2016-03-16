//
//  PPHeartView.swift
//  live
//
//  Created by chenpeiwei on 3/16/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit


class PPHeartView: UIView {
    
    
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
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(17.17, 0.77))
        bezierPath.addCurveToPoint(CGPointMake(14.42, 0), controlPoint1: CGPointMake(16.35, 0.28), controlPoint2: CGPointMake(15.42, 0))
        bezierPath.addCurveToPoint(CGPointMake(10.05, 2.24), controlPoint1: CGPointMake(12.67, 0), controlPoint2: CGPointMake(11.09, 0.87))
        bezierPath.addCurveToPoint(CGPointMake(5.68, 0), controlPoint1: CGPointMake(9.01, 0.87), controlPoint2: CGPointMake(7.44, 0))
        bezierPath.addCurveToPoint(CGPointMake(2.94, 0.77), controlPoint1: CGPointMake(4.68, 0), controlPoint2: CGPointMake(3.75, 0.28))
        bezierPath.addCurveToPoint(CGPointMake(0, 6.18), controlPoint1: CGPointMake(1.19, 1.82), controlPoint2: CGPointMake(0, 3.85))
        bezierPath.addCurveToPoint(CGPointMake(0.28, 8.09), controlPoint1: CGPointMake(0, 6.85), controlPoint2: CGPointMake(0.1, 7.49))
        bezierPath.addCurveToPoint(CGPointMake(10.05, 18.88), controlPoint1: CGPointMake(1.26, 12.86), controlPoint2: CGPointMake(10.05, 18.88))
        bezierPath.addCurveToPoint(CGPointMake(19.82, 8.09), controlPoint1: CGPointMake(10.05, 18.88), controlPoint2: CGPointMake(18.85, 12.86))
        bezierPath.addCurveToPoint(CGPointMake(20.1, 6.18), controlPoint1: CGPointMake(20, 7.49), controlPoint2: CGPointMake(20.1, 6.85))
        bezierPath.addCurveToPoint(CGPointMake(17.17, 0.77), controlPoint1: CGPointMake(20.1, 3.85), controlPoint2: CGPointMake(18.92, 1.83))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;
        
        fillColor.setFill()
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
