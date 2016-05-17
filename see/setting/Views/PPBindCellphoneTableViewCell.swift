//
//  PPBindCellphoneTableViewCell.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/13.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPBindCellphoneTableViewCell: UITableViewCell {

    var iconImageView: UIImageView!
    
    var descLabel: UILabel!
    
    var cellphoneNumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // Setup UI
    private func commonInit(){
        iconImageView =
            UIImageView.init(image: UIImage(named: "icon_cellphone_small"))
        iconImageView.contentMode = .Center
        self.contentView.addSubview(iconImageView)
        
        descLabel = UILabel()
        descLabel.text = "手机"
        descLabel.textColor = UIColor.blackColor()
        descLabel.textAlignment = .Left
        descLabel.font = UIFont.systemFontOfSize(14)
        self.contentView.addSubview(descLabel)
        
        cellphoneNumLabel = UILabel()
        cellphoneNumLabel.text = "+86 13526457852"
        cellphoneNumLabel.textAlignment = .Right
        cellphoneNumLabel.textColor = UIColor(hex: 0x000000, alpha: 0.5)
        cellphoneNumLabel.font = UIFont.systemFontOfSize(13)
        self.contentView.addSubview(cellphoneNumLabel)
        
        iconImageView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(16)
        }
        
        descLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(iconImageView.snp_right).offset(16)
        }
        
        cellphoneNumLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-16)
        }
    }
}
