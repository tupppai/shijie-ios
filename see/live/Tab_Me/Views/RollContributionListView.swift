//
//  rollContributionListView.swift
//  vision_demo
//
//  Created by TUPAI-Huangwei on 3/15/16.
//  Copyright © 2016 TUPAI-Huangwei. All rights reserved.
//

import UIKit

class RollContributionListView: UIView {
    
    @IBOutlet weak var avatarImageView1: UIImageView!
    
    @IBOutlet weak var avatarImageView2: UIImageView!
    
    @IBOutlet weak var avatarImageView3: UIImageView!
    
    @IBOutlet weak var rightIndicatorLabel: UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupSubviews()
    }
    
    convenience init(){
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    func setupSubviews(){
        let nib = UINib(nibName: "RollContributionListView",
            bundle: nil)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
}
