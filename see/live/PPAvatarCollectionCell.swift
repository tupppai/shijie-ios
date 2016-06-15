//
//  PPAvatarCollectionCell.swift
//  demo
//
//  Created by chenpeiwei on 3/18/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPAvatarCollectionCell: UICollectionViewCell {
    var imageView:PPRoundImageView!
    var friendModel:PPFriendModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()

        //weird though ,imageView.layer.border would cause unsmooth problem, seemingly can blame UICollectionViewCell
        let backgroundView = UIView(frame: CGRect(origin: CGPointMake(0, 0), size: CGSizeMake(frame.size.width, frame.size.height)))
        backgroundView.backgroundColor = UIColor.whiteColor()
        backgroundView.layer.cornerRadius = frame.size.width*0.5
        backgroundView.clipsToBounds = true
        
        self.addSubview(backgroundView)
        
        
        imageView = PPRoundImageView(frame: CGRect(origin: CGPointMake(1, 1), size: CGSizeMake(frame.size.width-2.0, frame.size.height-2.0)))
        
        self.addSubview(imageView)
        
        imageView.contentMode = .ScaleAspectFill
        imageView.backgroundColor = UIColor.whiteColor()
//        imageView.layer.borderColor = UIColor.greenColor().CGColor
//        imageView.layer.borderWidth = 2
        imageView.image = UIImage(named: "demoavatar.jpg")
        
    }
    
    func injectSource(friendModel:PPFriendModel?) {
        self.friendModel = friendModel
        imageView.sd_setImageWithURL(NSURL(string: friendModel?.avatarUrl ?? ""))
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
