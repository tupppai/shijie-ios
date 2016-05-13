//
//  PPGiftCollectionView.swift
//  vision_demo
//
//  Created by TUPAI-Huangwei on 3/21/16.
//  Copyright © 2016 TUPAI-Huangwei. All rights reserved.
//

import UIKit

class PPGiftCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        self.pagingEnabled                  = true
        self.showsHorizontalScrollIndicator = false
        self.allowsSelection                = true
        self.allowsMultipleSelection        = false
        self.backgroundColor                = UIColor.lightGrayColor()
    }
}
