//
//  PPGiftCell.swift
//  vision_demo
//
//  Created by TUPAI-Huangwei on 3/18/16.
//  Copyright © 2016 TUPAI-Huangwei. All rights reserved.
//

import UIKit

class PPGiftCell: UICollectionViewCell {

    
    @IBOutlet weak var testImageView: UIImageView!

    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var iconDiamondImageView: UIImageView!
   
    override var selected: Bool{
        didSet{
            if selected{
                iconDiamondImageView.highlighted = true
            }else{
               iconDiamondImageView.highlighted  = false
            }
        }
    }
    
    func bindModel(model: PPGiftModel){
        testImageView.image = UIImage(named: model.imageName)
        testLabel.text      = "\(model.diamondCount)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
