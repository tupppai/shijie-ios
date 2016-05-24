//
//  PPLoginViewController.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/14.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit
import PKHUD
import RealmSwift

class PPLoginViewController: UIViewController {
    
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
            getAuthInfoFromPlatform(PPOpenPlatformType.Weibo)
        }else if button === weixinButton{
            getAuthInfoFromPlatform(PPOpenPlatformType.Wechat)
        }else if button === qqButton{
            getAuthInfoFromPlatform(PPOpenPlatformType.QQ)
        }else if button === cellphoneButton{
        self.navigationController?.pushViewController(PPBindCellphoneViewController(), animated: true)
        }else{
            HUD.flash(.LabeledError(title: "Error", subtitle: "something wrong"))
        }
    }
    
    
    func getAuthInfoFromPlatform(platform:PPOpenPlatformType) {
        
        var platformType:PPOpenPlatformType = .Unknown
        
        platformType = platform
        
        PPShareManager.sharedInstance.superAuth(platformType, completionHandler: { (finished) in
            if finished {
                
                let param = PPShareInfo.sharedInstance.rawData as? [String:AnyObject]
                PPNetworkManager.postRequest("user/wechat-login", parameters: param).responseJSON(completionHandler: { (response) in
                    
                    switch response.result {
                    case .Success(let JSON):
                        let response = JSON as! NSDictionary
                        if let errCode = response.objectForKey("errCode") as? Int {
                            if errCode != PPNetworkResponseCode.Success.rawValue {
                                return
                            }
                        }
                        
                        let data = response.objectForKey("data") as? NSDictionary
                        let avatar = data?.objectForKey("avatar") as? String
                        let userID = data?.objectForKey("id") as? Int
                        let username = data?.objectForKey("nickname") as? String
                        
                        let realm = try! Realm()
                        try! realm.write {
                            PPUserModel.shareInstance.name = username ?? ""
                            PPUserModel.shareInstance.avatarUrl = avatar ?? ""
                            PPUserModel.shareInstance.ID = userID ?? 0
                            PPUserModel.shareInstance.login = true
                        }
                        
                        self.operationsAfterLoginSuccessFully()
                        HUD.flash(.LabeledSuccess(title: "微信登录成功", subtitle: ""), delay: 1.0)
                        self.dismiss()
                        
                    case .Failure:
                        HUD.flash(.Label("请求失败"), delay: 1.5)
                        break
                    }
                    
                    
                })
            }
        })
    }
    
    
    func operationsAfterLoginSuccessFully() {
        PPConnectRCIM(10)
    }

    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
