//
//  PPVIPSignupViewController.swift
//  see
//
//  Created by TUPAI-Huangwei on 16/5/20.
//  Copyright © 2016年 pires.inc. All rights reserved.
//

import UIKit
import PKHUD

class PPVIPSignupViewController: UIViewController {
    
    private var usernameInputView: PPVIPInfoInputView!
    
    private var cellphoneInputView: PPVIPInfoInputView!
    
    private var companyInputView: PPVIPInfoInputView!
    
    private var bindWechatView: PPVIPBindWechatView!
    
    private var commitButton: UIButton!
    
    // MARK: UI life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        self.view.backgroundColor = UIColor(hex: 0xF7F7F7)
        setupSubviews()
        setupConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UI setup
    
    private func setupSubviews(){
        usernameInputView  = PPVIPInfoInputView(placeHolderStr: "真实姓名")
        self.view.addSubview(usernameInputView)

        cellphoneInputView = PPVIPInfoInputView(placeHolderStr: "手机号")
        self.view.addSubview(cellphoneInputView)

        companyInputView   = PPVIPInfoInputView(placeHolderStr: "所在公司")
        self.view.addSubview(companyInputView)

        bindWechatView     = PPVIPBindWechatView()
        bindWechatView.bindWechatClosure = {
            [weak bindWechatView] in
            HUD.flash(.LabeledProgress(title: "注册中", subtitle: "跳转到微信页面..."), delay: 1, completion: { (finished) in
                if finished{
                    bindWechatView?.setBoundStatus(UIImage(named: "avatar_example5")!, username: "呵呵干嘛我在洗澡~")
                }
            })
        }
        self.view.addSubview(bindWechatView)
        
        commitButton = UIButton()
        commitButton.setTitle("提交", forState: .Normal)
        commitButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        commitButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        commitButton.setBackgroundImage(UIImage(named: "btn_orange_40pxH"), forState: .Normal)
        commitButton.addTarget(self, action: #selector(self.tapCommitButton), forControlEvents: .TouchUpInside)
        self.view.addSubview(commitButton)
        
    }
    
    private func setupConstraints(){
        usernameInputView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(60)
        }
        
        cellphoneInputView.snp_makeConstraints { (make) in
            make.top.equalTo(usernameInputView.snp_bottom).offset(1)
            make.left.right.equalTo(self.view)
            make.height.equalTo(60)
        }
        
        companyInputView.snp_makeConstraints { (make) in
            make.top.equalTo(cellphoneInputView.snp_bottom).offset(1)
            make.left.right.equalTo(self.view)
            make.height.equalTo(60)
        }
        
        bindWechatView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(companyInputView.snp_bottom).offset(10)
            make.height.equalTo(60)
        }
        
        commitButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(bindWechatView.snp_bottom).offset(22)
            make.size.equalTo(CGSize(width: 192, height: 44))
        }
        
    }
    
    // MARK: target-actions
    func tapCommitButton(){
        let commitSuccessView = PPVIPCommitSuccessView()
        commitSuccessView.show()
    }
}
