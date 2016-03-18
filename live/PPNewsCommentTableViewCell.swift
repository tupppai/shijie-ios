//
//  PP.swift
//  live
//
//  Created by chenpeiwei on 3/17/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPNewsCommentTableViewCell: UITableViewCell {
    
    var usernameLabel:UILabel?
    var contentLabel:UILabel?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        usernameLabel = UILabel()
        usernameLabel?.textAlignment = .Left
        usernameLabel?.textColor = UIColor.whiteColor()
        
        contentLabel = UILabel()
        contentLabel?.textAlignment = .Left
        contentLabel?.textColor = UIColor(hex: 0x564c7f)
        
        if #available(iOS 8.2, *) {
            usernameLabel?.font = UIFont.systemFontOfSize(13, weight: UIFontWeightRegular)
            contentLabel?.font = UIFont.systemFontOfSize(13, weight: UIFontWeightRegular)
        } else {
            usernameLabel?.font = UIFont.systemFontOfSize(13)
            contentLabel?.font = UIFont.systemFontOfSize(13)
        }
        
        }
    
    func render() {
        usernameLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.leading.equalTo(self)
            make.top.bottom.equalTo(self)
        })
        
        contentLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.leading.equalTo((usernameLabel?.snp_leading)!)
            make.top.bottom.equalTo(self)
            
        })
    }
    
    
  
}
