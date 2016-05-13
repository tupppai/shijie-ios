//
//  PPPodiumUserTableViewCell.swift
//  live
//
//  Created by TUPAI-Huangwei on 3/23/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPPodiumUserTableViewCell: UITableViewCell {

    @IBOutlet weak var rankNumberLabel: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var rankCountView: PPUserRankCountView!
    
    @IBOutlet weak var coinsSentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        rankNumberLabel.text    = "1"
        avatarImageView.image   = UIImage(named: "avatar_example_3")
        usernameLabel.text      = "Hehe"
        rankCountView.rankCount = 11
        coinsSentLabel.text     = "贡献了343434个马币"
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
