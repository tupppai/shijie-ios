//
//  PPDetailDisclosureTableViewCell.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/13.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPDetailDisclosureTableViewCell: UITableViewCell {

    var mainTitleLabel: UILabel!
    
    var subTitleLabel: UILabel!
    
    var rightIndicator: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: UI setup
    private func commonInit(){
        mainTitleLabel               = UILabel()
        mainTitleLabel.textColor     = UIColor.blackColor()
        mainTitleLabel.textAlignment = .Left
        mainTitleLabel.font = UIFont.systemFontOfSize(14)
        self.contentView.addSubview(mainTitleLabel)
        
        subTitleLabel               = UILabel()
        subTitleLabel.textColor     = UIColor(hex: 0x000000, alpha: 0.5)
        subTitleLabel.textAlignment = .Left
        subTitleLabel.font = UIFont.systemFontOfSize(14)
        self.contentView.addSubview(subTitleLabel)
        
        rightIndicator = UIImageView(image: UIImage(named: "icon_segueRight"))
        self.contentView.addSubview(rightIndicator)
        
        mainTitleLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(16)
        }
        
        rightIndicator.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-16)
        }
        
        subTitleLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(rightIndicator.snp_left).offset(-10)
        }
    }

}
