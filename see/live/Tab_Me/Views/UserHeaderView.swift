//
//  TableViewHeaderView.swift
//  vision_demo
//
//  Created by TUPAI-Huangwei on 3/15/16.
//  Copyright © 2016 TUPAI-Huangwei. All rights reserved.
//

import UIKit

class UserHeaderView: UIView {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var iDLabel: UILabel!
    
    @IBOutlet weak var diamondSentCountLabel: UILabel!
    
    @IBOutlet weak var broadcastButton: CountButton!
    
    @IBOutlet weak var followingButton: CountButton!
    
    @IBOutlet weak var fansButton: CountButton!
    
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
        let nib = UINib(nibName: "UserHeaderView",
            bundle: nil)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        
        self.broadcastButton.numberCountLabel.text = "109"
        self.broadcastButton.typeStr.text          = "直播"

        self.followingButton.numberCountLabel.text = "34"
        self.followingButton.typeStr.text          = "关注"

        self.fansButton.numberCountLabel.text      = "12"
        self.fansButton.typeStr.text               = "粉丝"
        
    }
}
