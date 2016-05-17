//
//  PPLoginViewController2.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/14.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit
import PKHUD

class PPLoginViewController2: UIViewController {
    
    // MARK: Variables
    
    private var logoImageView: UIImageView!
    
    private var thirdPlatformButtonsContainerView: UIView!
    
    private var weixinButton: UIButton!
    
    private var qqButton: UIButton!
    
    private var weiboButton: UIButton!
    
    private var cellphoneButton: UIButton!
    
    // MARK: UI life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        setupSubviews()
        setupConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: UI setup
    private func setupSubviews(){
        logoImageView = UIImageView(image: UIImage(named: "icon_logo"))
        self.view.addSubview(logoImageView)
        
        thirdPlatformButtonsContainerView = UIView()
        thirdPlatformButtonsContainerView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(thirdPlatformButtonsContainerView)
        
        weixinButton = UIButton()
        weixinButton.setBackgroundImage(UIImage(named: "icon_weixin_big"), forState: .Normal)
        weixinButton.contentMode = .Center
        weixinButton.addTarget(self, action: #selector(self.tapButton(_:)), forControlEvents: .TouchUpInside)
        thirdPlatformButtonsContainerView.addSubview(weixinButton)
        
        
        qqButton = UIButton()
        qqButton.setBackgroundImage(UIImage(named: "icon_qq_big"), forState: .Normal)
        qqButton.addTarget(self, action: #selector(self.tapButton(_:)), forControlEvents: .TouchUpInside)
        thirdPlatformButtonsContainerView.addSubview(qqButton)
        
        weiboButton = UIButton()
        weiboButton.setBackgroundImage(UIImage(named: "icon_weibo_big"), forState: .Normal)
        weiboButton.addTarget(self, action: #selector(self.tapButton(_:)), forControlEvents: .TouchUpInside)
        thirdPlatformButtonsContainerView.addSubview(weiboButton)
        
        cellphoneButton = UIButton(type: .System)
        cellphoneButton.setTitle("测试：手机登录", forState: .Normal)
        cellphoneButton.addTarget(self, action: #selector(self.tapButton(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(cellphoneButton)
        
    }
    
    private func setupConstraints(){
        logoImageView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(86)
        }
        
        cellphoneButton.snp_makeConstraints { (make) in
            make.center.equalTo(self.view)
        }
        
        thirdPlatformButtonsContainerView.snp_makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(161)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-39)
        }
        
        weixinButton.snp_makeConstraints { (make) in
            make.width.equalTo(40)
            make.top.bottom.left.equalTo(thirdPlatformButtonsContainerView)
        }
        
        qqButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(thirdPlatformButtonsContainerView)
            make.left.equalTo(weixinButton.snp_right).offset(20)
            make.width.equalTo(40)
        }
        
        weiboButton.snp_makeConstraints { (make) in
            make.top.bottom.right.equalTo(thirdPlatformButtonsContainerView)
            make.left.equalTo(qqButton.snp_right).offset(20)
        }
        
    }
    
    // MARK: target-Actions
    func tapButton(button: UIButton){
        if button === weiboButton {
            HUD.flash(.Label("weibo"))
        }else if button === weixinButton{
            HUD.flash(.Label("weixin"))
        }else if button === qqButton{
            HUD.flash(.Label("QQ"))
        }else if button === cellphoneButton{
        self.navigationController?.pushViewController(PPBindCellphoneViewController(), animated: true)
        }else{
            HUD.flash(.LabeledError(title: "Error", subtitle: "something wrong"))
        }
    }
    
    
}
