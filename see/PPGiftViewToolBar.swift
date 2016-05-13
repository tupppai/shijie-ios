//
//  PPGiftViewToolBar.swift
//  vision_demo
//
//  Created by TUPAI-Huangwei on 3/18/16.
//  Copyright © 2016 TUPAI-Huangwei. All rights reserved.
//

import UIKit

protocol PPGiftViewToolBarDelegate: class{
    func toolBarDidCharge(toolBar:PPGiftViewToolBar)
    func toolBarDidSendDiamond(toolBar:PPGiftViewToolBar)
}

class PPGiftViewToolBar: UIView {

    @IBOutlet weak var sendGiftButton: UIButton!
    @IBOutlet weak var diamondCountLabel: UILabel!
    @IBOutlet private weak var chargeLabel: UILabel!
    @IBOutlet private weak var diamondImageView: UIImageView!
    
    weak var delegate: PPGiftViewToolBarDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        diamondCountLabel.text = "0"
        
        let tapOnChargeLabel = UITapGestureRecognizer(target: self, action: "tapOnChargeAction")
        chargeLabel.addGestureRecognizer(tapOnChargeLabel)
        
        let tapOnDiamondCountLabel = UITapGestureRecognizer(target: self, action: "tapOnChargeAction")
        diamondCountLabel.addGestureRecognizer(tapOnDiamondCountLabel)
        
        let tapOnDiamondImageView = UITapGestureRecognizer(target: self, action: "tapOnChargeAction")
        diamondImageView.addGestureRecognizer(tapOnDiamondImageView)
        
        chargeLabel.userInteractionEnabled       = true
        diamondCountLabel.userInteractionEnabled = true
        diamondImageView.userInteractionEnabled  = true
        
        sendGiftButton.addTarget(self, action: Selector("pressSentButton"), forControlEvents: .TouchUpInside)
    }
    
    class func toolBar() -> PPGiftViewToolBar{
        return NSBundle.mainBundle().loadNibNamed("PPGiftViewToolBar", owner: nil, options: nil).last as! PPGiftViewToolBar
    }
    
    // MARK: Target-Actions
    func tapOnChargeAction(){
        delegate?.toolBarDidCharge(self)
    }
    
    func pressSentButton(){
        delegate?.toolBarDidSendDiamond(self)
    }
}
