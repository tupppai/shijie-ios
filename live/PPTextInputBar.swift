//
//  PPTextInputBar.swift
//  live
//
//  Created by chenpeiwei on 3/21/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPTextInputBar: UIView {
    var sendButton:UIButton!
    var textField:UITextField!
    
    let height = 38
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        sendButton = UIButton(type: .Custom)
        sendButton.setTitle("发送", forState: .Normal)
        sendButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        sendButton.setTitleColor(UIColor.blackColor(), forState: .Highlighted)

        sendButton.backgroundColor = UIColor(hex: 0x564c7f)
        sendButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        
        textField = UITextField()
        textField.backgroundColor = UIColor.whiteColor()
//        textField.layer.cornerRadius = 4
//        textField.clipsToBounds = true
        
        self.addSubview(sendButton)
        self.addSubview(textField)

        sendButton.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(70)
            make.height.equalTo(height)
            make.trailing.equalTo(self).offset(0)
            make.centerY.equalTo(self)
        }
        textField.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(self).offset(0)
            make.height.equalTo(sendButton)
            make.trailing.equalTo(sendButton.snp_leading).offset(0)
            make.centerY.equalTo(self)
        }
    }
}
