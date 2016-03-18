//
//  userDetailPanelView.swift
//  vision_demo
//
//  Created by TUPAI-Huangwei on 3/15/16.
//  Copyright © 2016 TUPAI-Huangwei. All rights reserved.
//

import UIKit

class UserDetailPanelView: UIView {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var certificateLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!

    @IBOutlet weak var followingCountLabel: UILabel!
    
    @IBOutlet weak var followedCountLabel: UILabel!
    
    @IBOutlet weak var diamondSentCountLabel: UILabel!
    
    @IBOutlet weak var visionTicketCountLabel: UILabel!
    
    @IBOutlet weak var followButton: UIButton!
    
    @IBOutlet weak var replyButton: UIButton!

    @IBOutlet weak var homepageButton: UIButton!
    
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
        let nib = UINib(nibName: "UserDetailPanelView",
            bundle: nil)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
}
