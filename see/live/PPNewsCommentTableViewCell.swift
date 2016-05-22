//
//  PP.swift
//  live
//
//  Created by chenpeiwei on 3/17/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPNewsCommentTableViewCell: UITableViewCell {
    
    var liveCommentModel:PPLiveCommentModel?
    var usernameLabel:UILabel?
//    var contentLabel:UILabel?
    let array = ["PeiweiReporter💗 : 杜克大学今天也顺利赢球，他们击败了耶鲁大学。NBA选秀热门布兰登-英格拉姆贡献25分。但球队最高分是格雷森-阿伦的29分。","PeiweiReporter💗 : lets you use the attributed","PeiweiReporter💗 : 整个总决赛5战，哈达迪场均攻下21.6分19.2个篮板"]
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = .None
        setupViews()
    }
    
    func injectSource(liveCommentModel:PPLiveCommentModel?) {
        self.liveCommentModel = liveCommentModel
        guard let liveCommentModel = liveCommentModel else{
            return
        }
//        liveCommentModel.comment = "hello"
        if let senderName = liveCommentModel.senderName as String! {
                    usernameLabel?.text = "\(senderName):\(liveCommentModel.content)"
                    usernameLabel?.setTextColor(UIColor(hex: 0x564c7f), string: "\(senderName):")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        usernameLabel = UILabel()
        usernameLabel?.textAlignment = .Left
        usernameLabel?.textColor = UIColor.whiteColor()
    
        
        
        usernameLabel?.numberOfLines = 0
        
        contentView.addSubview(usernameLabel!)
//        contentLabel = UILabel()
//        contentLabel?.textAlignment = .Left
//        contentLabel?.textColor = UIColor(hex: 0x564c7f)
//        
        if #available(iOS 8.2, *) {
            usernameLabel?.font = UIFont.systemFontOfSize(13, weight: UIFontWeightRegular)
//            contentLabel?.font = UIFont.systemFontOfSize(13, weight: UIFontWeightRegular)
        } else {
            usernameLabel?.font = UIFont.systemFontOfSize(13)
//            contentLabel?.font = UIFont.systemFontOfSize(13)
        }
        render()
        
        }
    
    func render() {
        usernameLabel?.snp_makeConstraints(closure: { (make) -> Void in
           make.edges.equalTo(self.contentView).inset(UIEdgeInsetsMake(0, 4, 0, 0))
        })
        
//        contentLabel?.snp_makeConstraints(closure: { (make) -> Void in
//            make.leading.equalTo((usernameLabel?.snp_leading)!)
//            make.top.bottom.equalTo(self)
//            
//        })
    }
    
    
  
}
