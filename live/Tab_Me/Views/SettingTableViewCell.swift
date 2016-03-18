//
//  SettingTableViewCell.swift
//  vision_demo
//
//  Created by TUPAI-Huangwei on 3/15/16.
//  Copyright © 2016 TUPAI-Huangwei. All rights reserved.
//

import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var settingIndicatorImageView: UIImageView!
    
    @IBOutlet weak var settingTextLabel: UILabel!
    
    @IBOutlet weak var numberCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // add a cell separator line which is only 1 px height
        let cellSeparator = UIView()
        cellSeparator.backgroundColor = UIColor(hex: 0xe5e5e5)
        self.addSubview(cellSeparator)
        cellSeparator.snp_makeConstraints { [weak self] (make) -> Void in
            make.height.equalTo(0.5)
            make.left.equalTo(self!.settingIndicatorImageView.snp_left)
            make.right.equalTo((self?.snp_right)!).offset(-15)
            make.bottom.equalTo((self?.snp_bottom)!)
        }
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
