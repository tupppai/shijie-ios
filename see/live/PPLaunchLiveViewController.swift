//
//  PPLaunchLiveViewController.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/11.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

class PPLaunchLiveViewController: UIViewController {
    
    private var hashtagLabel: UILabel!
    
    private var toggleHashtagButton: UIButton!
    
    private var dismissButton: UIButton!
    
    private var titleTextField: UITextField!
    
    private var shareButtonsView: PPLiveShareButtonsView!
    
    private var beginLiveButton: UIButton!
    
    // MARK: UI life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        PPCloseMyAbandonedLiveRoom()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor(hex: 0x000000, alpha: 0.8)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        titleTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UI setup
    private func setupSubviews(){
        // # 频道主题 #
        hashtagLabel               = UILabel()
        hashtagLabel.text          = "# 频道主题 #"
        hashtagLabel.textColor     = UIColor.whiteColor()
        hashtagLabel.font          = UIFont.systemFontOfSize(17);
        hashtagLabel.textAlignment = .Left
        self.view.addSubview(hashtagLabel)
        
        // "换一个"button
        toggleHashtagButton = UIButton()
        toggleHashtagButton.setImage(UIImage(named: "btn_toggle"), forState: .Normal)
        self.view.addSubview(toggleHashtagButton)
        
        // 退出 button
        dismissButton = UIButton()
        dismissButton.setImage(UIImage(named: "ic_close_black"), forState: .Normal)
        dismissButton.addTarget(self, action: #selector(PPLaunchLiveViewController.dismiss), forControlEvents: .TouchUpInside)
        self.view.addSubview(dismissButton)
        
        // 标题 textfield
        titleTextField               = UITextField()
        titleTextField.borderStyle   = .None
        titleTextField.font          = UIFont.systemFontOfSize(15)
        titleTextField.textColor     = UIColor.whiteColor()
        let placeholderColor = UIColor(hex: 0xFFFFFF, alpha: 0.5)
        titleTextField.attributedPlaceholder =
            NSAttributedString(string: "给你的直播写个标题吧",
                               attributes:
                [NSForegroundColorAttributeName: placeholderColor])
        titleTextField.textAlignment = .Left
        self.view.addSubview(titleTextField)
        
        // 分享buttons
        shareButtonsView = PPLiveShareButtonsView()
        self.view.addSubview(shareButtonsView)
        
        // 开始直播button
        beginLiveButton = UIButton()
        beginLiveButton.setBackgroundImage(UIImage(named: "btn_big"), forState: .Normal)
        beginLiveButton.setTitle("现在直播", forState: .Normal)
        beginLiveButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        beginLiveButton.titleLabel!.font = UIFont.systemFontOfSize(16)
        beginLiveButton.contentMode = .Center
        
        beginLiveButton.addTarget(self, action: #selector(PPLaunchLiveViewController.beginLiving), forControlEvents: .TouchUpInside)
        self.view.addSubview(beginLiveButton)
    }
    
    
    private func setupConstraints(){
        hashtagLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(25)
            make.left.equalTo(self.view).offset(25)
            make.width.lessThanOrEqualTo(self.view).multipliedBy(0.4).priorityHigh()
        }
        
        toggleHashtagButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(hashtagLabel)
            make.left.equalTo(hashtagLabel.snp_right).offset(10)
            make.size.equalTo(CGSize(width: 55, height: 25))
        }
        
        dismissButton.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 26,height: 26))
            make.top.equalTo(self.view).offset(18)
            make.right.equalTo(self.view).offset(-14)
        }
        
        titleTextField.snp_makeConstraints { (make) in
            make.left.equalTo(hashtagLabel)
            make.right.equalTo(dismissButton.snp_left).offset(-10)
            make.top.equalTo(hashtagLabel.snp_bottom).offset(16)
            make.height.equalTo(100)
        }
        
        shareButtonsView.snp_makeConstraints { (make) in
            make.height.equalTo(20)
            make.left.right.equalTo(titleTextField)
            make.top.equalTo(titleTextField.snp_bottom).offset(40)
        }
        
        beginLiveButton.snp_makeConstraints { (make) in
            make.left.equalTo(self.view).offset(30)
            make.right.equalTo(self.view).offset(-30)
            make.height.equalTo(48)
            make.top.equalTo(shareButtonsView.snp_bottom).offset(23)
        }
    }
    
    // MARK: target-actions
    func dismiss(){
        self.view.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func beginLiving(){
        self.view.endEditing(true)
        self.dismissViewControllerAnimated(false) { 
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            let vc = PPMyLiveViewController()
            vc.title = self.titleTextField.text
            appDelegate.window?.rootViewController?.presentViewController(PPMyLiveViewController(), animated: true, completion: nil)
            
        }
    }
}
