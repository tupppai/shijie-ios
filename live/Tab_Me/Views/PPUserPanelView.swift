//
//  PPUserPanelView.swift
//  live
//
//  Created by chenpeiwei on 3/21/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import Foundation
import UIKit

class PPUserPanelView:SpringView {
    
    var avatarImageView:PPRoundImageView!
    var userDatailPanelView:PPUserDetailPanelView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        avatarImageView = PPRoundImageView()
        avatarImageView?.backgroundColor = UIColor.lightGrayColor()
        avatarImageView.image = UIImage(named: "demoavatar.jpg")
        avatarImageView.layer.borderWidth = 2.0
        avatarImageView.layer.borderColor = UIColor.whiteColor().CGColor
        
        userDatailPanelView = PPUserDetailPanelView()
        userDatailPanelView.layer.cornerRadius = 4
        userDatailPanelView.clipsToBounds = true
        
        self.addSubview(userDatailPanelView!)
        self.addSubview(avatarImageView!)

        userDatailPanelView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self).inset(UIEdgeInsetsMake(34, 0, 0, 0))
        }
      

        
        avatarImageView?.snp_makeConstraints(closure: { (make) -> Void in
            make.width.height.equalTo(68)
            make.top.equalTo(self)
            make.centerX.equalTo(self)
        })
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}