//
//  PPGiftShowsAnimateView.swift
//  live
//
//  Created by chenpeiwei on 3/21/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPGiftShowsAnimateView: UIView {
    var giftShowView1:PPGiftShowView!
    var giftShowView2:PPGiftShowView!
    
    
    func show() {

        
        showGiftShowView1()
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * CGFloat(NSEC_PER_SEC)))
        let delayTime2 = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * CGFloat(NSEC_PER_SEC)))
        let delayTime3 = dispatch_time(DISPATCH_TIME_NOW, Int64(8 * CGFloat(NSEC_PER_SEC)))

        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.showGiftShowView2()
//            self.hideGiftShowView1()
        }
        
        dispatch_after(delayTime2, dispatch_get_main_queue()) {
            self.hideGiftShowView2()
        }
        
        dispatch_after(delayTime3, dispatch_get_main_queue()) {
            self.showGiftShowView2()
        }

    }
    
    func showGiftShowView1() {
        giftShowView1.hidden = false
        giftShowView1.animation = "slideRight"
        giftShowView1.curve = "easeOut"
        giftShowView1.duration = 1.0
        giftShowView1.animate()
    }
    
    func showGiftShowView2() {
        self.giftShowView2.hidden = false
        self.giftShowView2.animation = "slideRight"
        self.giftShowView2.curve = "easeOut"
        self.giftShowView2.duration = 1.0
        self.giftShowView2.animate()
    }
    
    func hideGiftShowView1() {
        giftShowView1.animation = "fadeOut"
        giftShowView1.curve = "easeOut"
        giftShowView1.duration = 1.0
        giftShowView1.animate()
    }
    
    func hideGiftShowView2() {
        self.giftShowView2.animation = "fadeOut"
        self.giftShowView2.curve = "easeOut"
        self.giftShowView2.duration = 1.0
        self.giftShowView2.animate()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        giftShowView1 = PPGiftShowView()
        giftShowView2 = PPGiftShowView()
        
        giftShowView1.hidden = true
        giftShowView2.hidden = true

        self.addSubview(giftShowView1)
        self.addSubview(giftShowView2)
        render()
    }
    
    func render() {
        
        giftShowView1.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self)
            make.leading.equalTo(self).offset(12)
            make.width.equalTo(180)
            make.height.equalTo(45)
        }
        giftShowView2.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(giftShowView1.snp_bottom).offset(12)
            make.leading.equalTo(self).offset(12)
            make.width.equalTo(180)
            make.height.equalTo(45)
        }
        
        
        
    }
}
