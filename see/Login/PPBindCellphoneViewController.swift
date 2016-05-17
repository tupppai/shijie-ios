//
//  PPBindCellphoneViewController.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/16.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit
import PKHUD

class PPBindCellphoneViewController: UIViewController {

    private var cellphoneTextField : UITextField!
    
    private var authCodeTextField: UITextField!
    
    private var finishButton: UIButton!
    
    private var fetchAuthCodeButton: UIButton!
    
    // MARK: UI life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: 0xF7F7F7)
        self.edgesForExtendedLayout = .None
        setupSubviews()
        setupConstraints()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UI setup
    private func setupSubviews(){
        cellphoneTextField = UITextField()
        cellphoneTextField.background = UIImage(named: "textfield_thinBorder")
        cellphoneTextField.borderStyle = .None
        cellphoneTextField.placeholder = "请输入手机号码"
        cellphoneTextField.font = UIFont.systemFontOfSize(14)
        self.view.addSubview(cellphoneTextField)
        
        fetchAuthCodeButton = UIButton()
        fetchAuthCodeButton.frame = CGRect(x: 0, y: 0, width: 55, height: 25)
        fetchAuthCodeButton.setBackgroundImage(UIImage(named: "btn_small_orange"), forState: .Normal)
        fetchAuthCodeButton.setTitle("验证", forState: .Normal)
        fetchAuthCodeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        fetchAuthCodeButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        cellphoneTextField.rightView = fetchAuthCodeButton
        cellphoneTextField.rightViewMode = .Always
        
        authCodeTextField = UITextField()
        authCodeTextField.background = UIImage(named: "textfield_thinBorder")
        authCodeTextField.borderStyle = .None
        authCodeTextField.placeholder = "请输入手机验证码"
        authCodeTextField.font = UIFont.systemFontOfSize(14)
        self.view.addSubview(authCodeTextField)
        
        finishButton = UIButton()
        finishButton.setTitle("完成", forState: .Normal)
        finishButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        finishButton.setBackgroundImage(UIImage(named: "btn_big"), forState: .Normal)
        finishButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.view.addSubview(finishButton)
    }
    
    private func setupConstraints(){
        cellphoneTextField.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(20)
            make.left.equalTo(self.view).offset(16)
            make.right.equalTo(self.view).offset(-16)
            make.height.equalTo(45)
        }
        
        authCodeTextField.snp_makeConstraints { (make) in
            make.top.equalTo(cellphoneTextField.snp_bottom).offset(15)
            make.left.equalTo(self.view).offset(16)
            make.right.equalTo(self.view).offset(-16)
            make.height.equalTo(45)
        }
        
        finishButton.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 192,height: 46))
            make.centerX.equalTo(self.view)
            make.top.equalTo(authCodeTextField.snp_bottom).offset(25)
        }
    }
    
    private func setupNavBar(){
        self.navigationItem.title = "绑定手机号"
        let barButton = UIBarButtonItem(title: "跳过", style: .Plain , target: self, action: nil)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    // MARK: target-actions
    func tapFetchAuthCodeButton(){
        HUD.flash(.Label("获取验证码"))
    }
    
    func tapFinishButton(){
        HUD.flash(.Label("完成绑定"))
    }
}
