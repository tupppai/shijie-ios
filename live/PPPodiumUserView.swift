//
//  PPPodiumUserView.swift
//  live
//
//  Created by TUPAI-Huangwei on 3/23/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPPodiumUserView: UIView {
    
    @IBOutlet weak var avatarImageView: PPRoundImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    var user: PPUserModel
    
    override init(frame: CGRect){
        user = PPUserModel(avatarImageUrl: "nil", username: "nil", coinsContributed: 0, ranking: 0)
        super.init(frame: frame)
        setupSubviews()
    }
    
    convenience init(){
        self.init(frame: CGRect.zero)
    }
    
    convenience init(user: PPUserModel){
        self.init(frame: CGRect.zero)
        self.user = user
    }
    
    required init?(coder aDecoder: NSCoder) {
        user = PPUserModel(avatarImageUrl: "nil", username: "nil", coinsContributed: 0, ranking: 0)
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    func setupSubviews(){
        let nib = UINib(nibName: "PPPodiumUserView",
            bundle: nil)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        
        avatarImageView.layer.borderColor = UIColor(hex: 0xFFA403).CGColor
        avatarImageView.layer.borderWidth = 3.0
    }
}
