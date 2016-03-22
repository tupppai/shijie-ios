//
//  PPHeartFloatingView.swift
//  live
//
//  Created by chenpeiwei on 3/22/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPHeartFloatingView: UIView {

    
    
    func setupHeartBalloonGenerator() {
        NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "fireBallon", userInfo: nil, repeats: true)
    }


    func fireBallon() {
        let delaySec = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delaySec * CGFloat(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            let heart = PPLovingHeartView()
            
            let viewHeight = CGRectGetHeight(self.frame)
            let viewWidth = CGRectGetWidth(self.frame)
            heart.frame = CGRectMake(viewWidth*0.5-10, viewHeight - 20, 20, 20)
            self.addSubview(heart)
            
            var frame = heart.frame
            let viewWidth_half = Int(viewWidth*0.5)
            let xAnimateNumber = CGFloat(randInRange(-viewWidth_half...viewWidth_half))
            if abs(xAnimateNumber)>25 {
                heart.animation = "swing"
                heart.curve = "spring"
                heart.force =  1.0
                heart.duration =  8
                heart.animate()
            }
            else if abs(xAnimateNumber)>10 {
                heart.animation = "shake"
                heart.curve = "linear"
                heart.force =  1.0
                heart.duration =  8
                heart.animate()
            } else {
                
            }
            frame.origin.x += xAnimateNumber
            
            
            UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
                heart.frame = frame
                }, completion: { (finished) -> Void in
            })
            
            UIView.animateWithDuration(8.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                heart.frame = CGRectMake(viewWidth*0.5, 0, 20, 20)
                heart.alpha = 0.0
                }, completion: { (finished) -> Void in
                    heart .removeFromSuperview()
            })
        }
    }

}
