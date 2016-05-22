//
//  PPVIPInfoInputView.swift
//  see
//
//  Created by TUPAI-Huangwei on 16/5/20.
//  Copyright © 2016年 pires.inc. All rights reserved.
//

import UIKit

class PPVIPInfoInputView: UIView {

    private var textField: UITextField!
    
    var placeHolderStr: String?
    
    var infoStr: String{
        get{
            return textField.text ?? ""
        }
    }
    
    // MARK: Init methods
    override init(frame: CGRect){
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    convenience init(placeHolderStr: String){
        self.init(frame: CGRect.zero)
        textField.placeholder = placeHolderStr
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: UI setup
    private func setupSubviews(){
        self.backgroundColor  = UIColor.whiteColor()
        textField             = UITextField()
        textField.placeholder = placeHolderStr
        textField.font        = UIFont.systemFontOfSize(15)
        textField.borderStyle = .None
        self.addSubview(textField)
    }
    
    private func setupConstraints(){
        textField.snp_makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
        }
    }
}
