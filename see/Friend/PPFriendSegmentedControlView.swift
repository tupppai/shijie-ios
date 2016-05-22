//
//  PPFriendSegmentedControlView.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/16.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

@objc protocol PPFriendSegmentedControlViewDelegate {
    func segmentedControl(segmentedControl: PPFriendSegmentedControlView, didSelectIndex: Int)
}

class PPFriendSegmentedControlView: UIView {
    
    weak var delegate: PPFriendSegmentedControlViewDelegate?
    
    var broadcastCount: Int? {
        didSet{
            let broadCastTitle = "\(broadcastCount ?? 0) 直播"
            broadcastButton.setTitle(broadCastTitle, forState: .Normal)
        }
    }
    
    var momentsCount: Int? {
        didSet{
            let momentsTitle = "\(momentsCount ?? 0) 动态"
            momentsButton.setTitle(momentsTitle, forState: .Normal)
        }
    }
    
    private var broadcastButton: UIButton!
    
    private var momentsButton: UIButton!
    
    private var bottomLineIndicator: UIView!
    
    private var k_selectedIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: UI setup
    private func commonInit(){
        self.backgroundColor = UIColor.whiteColor()
        
        broadcastButton = UIButton()
        broadcastButton.tag = 0
        let broadCastTitle = "\(broadcastCount ?? 0) 直播"
        broadcastButton.setTitle(broadCastTitle, forState: .Normal)
        broadcastButton.setTitleColor(UIColor(hex: 0x000000), forState: .Normal)
        broadcastButton.setTitleColor(UIColor(hex: 0xFF5722), forState: .Selected)
        broadcastButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        broadcastButton.selected = true
        broadcastButton.addTarget(self, action: #selector(PPFriendSegmentedControlView.tapButton(_:)), forControlEvents: .TouchUpInside)
        self.addSubview(broadcastButton)
        
        momentsButton = UIButton()
        momentsButton.tag = 1
        let momentsTitle = "\(momentsCount ?? 0) 动态"
        momentsButton.setTitle(momentsTitle, forState: .Normal)
        momentsButton.setTitleColor(UIColor(hex: 0x000000), forState: .Normal)
        momentsButton.setTitleColor(UIColor(hex: 0xFF5722), forState: .Selected)
        momentsButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        momentsButton.selected = false
        momentsButton.addTarget(self, action: #selector(PPFriendSegmentedControlView.tapButton(_:)), forControlEvents: .TouchUpInside)
        self.addSubview(momentsButton)
        
        bottomLineIndicator = UIView()
        bottomLineIndicator.backgroundColor = UIColor(hex: 0xFF5722)
        self.addSubview(bottomLineIndicator)
        
    }
    
    // MARK: target-Actions
    func tapButton(button: UIButton){
        let index = button.tag
        if index == 0 {
            delegate?.segmentedControl(self, didSelectIndex: 0)
            k_selectedIndex = 0
            self.setNeedsLayout()
            UIView.animateWithDuration(0.3, animations: {
                self.broadcastButton.selected = true
                self.momentsButton.selected   = false
                self.layoutIfNeeded()
            })
        }else if index == 1{
            delegate?.segmentedControl(self, didSelectIndex: 1)
            k_selectedIndex = 1
            self.setNeedsLayout()
            UIView.animateWithDuration(0.3, animations: {
                self.broadcastButton.selected = false
                self.momentsButton.selected   = true
                self.layoutIfNeeded()
            })
            
        }
    }
    // MARK: Layout procedure
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonW = self.frame.size.width / 2
        let buttonH = self.frame.size.height
        broadcastButton.frame = CGRect(x: 0, y: 0, width: buttonW, height: buttonH)
        momentsButton.frame   = CGRect(x: buttonW, y: 0, width: buttonW, height: buttonH)
        
        
        let lineH = CGFloat(3.0)
        let lineY = buttonH - lineH
        let lineW = buttonW * 0.6
        let lineX = (CGFloat(k_selectedIndex) * buttonW) + (buttonW - lineW) * 0.5
        
        bottomLineIndicator.frame = CGRect(x: lineX, y: lineY, width: lineW, height: lineH)
    }
    
}

