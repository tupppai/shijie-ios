//
//  PPAvatarCollectionCell.swift
//  demo
//
//  Created by chenpeiwei on 3/18/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPAvatarCollectionCell: UICollectionViewCell {
    var imageView:UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
        imageView = UIImageView(frame: CGRect(origin: CGPointZero, size: frame.size))
        self.addSubview(imageView)
        imageView.contentMode = .ScaleAspectFill
        imageView.image = UIImage(named: "demo")
        imageView.backgroundColor = UIColor.whiteColor()
        imageView.layer.cornerRadius = 35*0.5
        imageView.layer.borderColor = UIColor.greenColor().CGColor
        imageView.layer.borderWidth = 2
        imageView.layer.masksToBounds = true
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
