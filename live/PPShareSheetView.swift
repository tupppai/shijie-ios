//
//  PPShareSheetView.swift
//  live
//
//  Created by chenpeiwei on 3/17/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPShareSheetView: UIView {
    
    
    var button1:PPShareButton!
    var button2:PPShareButton!
    var button3:PPShareButton!
    var button4:PPShareButton!
    var button5:PPShareButton!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex: 0x000000, alpha: 0.7)
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews() {
        
        button1 = styleButton("微博",imageName: "live-share-sinaweibo")
        button2 = styleButton("朋友圈",imageName:"live-share-wechatmoment")
        button3 = styleButton("微信",imageName:"live-share-wechat")
        button4 = styleButton("QQ",imageName:"live-share-qq")
        button5 = styleButton("QQ空间",imageName:"live-share-qzone")
        
        button1.tag = 1
        button2.tag = 2
        button3.tag = 3
        button4.tag = 4
        button5.tag = 5

       
        self.addSubview(button1)
        self.addSubview(button2)
        self.addSubview(button3)
        self.addSubview(button4)
        self.addSubview(button5)

        render()

    }
    
    func styleButton(title:String!,imageName:String!)->PPShareButton {
        let button = PPShareButton(type: .Custom)
        button .setTitle(title, forState: .Normal)
        button.setImage(UIImage(named: imageName), forState:.Normal)
        return button
    }
    
    func render() {
        
        button1.snp_makeConstraints { (make) -> Void in
            
            make.top.leading.trailing.equalTo(self)
            
            make.leading.equalTo(button2)
            make.leading.equalTo(button3)
            make.leading.equalTo(button4)
            make.leading.equalTo(button5)

            make.width.equalTo(button2)
            make.width.equalTo(button3)
            make.width.equalTo(button4)
            make.width.equalTo(button5)

            make.height.equalTo(button2)
            make.height.equalTo(button3)
            make.height.equalTo(button4)
            make.height.equalTo(button5)

        }
        
        button2.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(button1.snp_bottom)
        }
        
        button3.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(button2.snp_bottom)
        }
        button4.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(button3.snp_bottom)
        }

        button5.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(button4.snp_bottom)
            make.bottom.equalTo(self)

        }
        
    }


}
