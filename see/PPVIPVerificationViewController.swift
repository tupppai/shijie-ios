//
//  PPVIPVerificationViewController.swift
//  see
//
//  Created by TUPAI-Huangwei on 16/5/19.
//  Copyright © 2016年 pires.inc. All rights reserved.
//

import UIKit
import PKHUD

class PPVIPVerificationViewController: UIViewController {

    
    private var welcomeLabel: UILabel!
    
    private var vipBackgroundImageView: UIImageView!
    
    private var verifyButton: UIButton!
    
    private var knowMoreButton: UIButton!
    
    // MARK: UI life cycless
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupGradientBackground()
        setupSubviews()
        setupConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
         self.navigationController?.navigationBar.tintColor = UIColor(hex: 0x007AFF)
        self.navigationController?.navigationBar.lt_reset()
    }
    
    // MARK: UI setup
    private func setupSubviews(){
        welcomeLabel = UILabel()
        welcomeLabel.text = "欢迎成为See主播！"
        welcomeLabel.textColor = UIColor.whiteColor()
        welcomeLabel.font = UIFont.systemFontOfSize(15)
        welcomeLabel.textAlignment = .Center
        self.view.addSubview(welcomeLabel)
        
        var imageFilePath: String
        if ScreenSize.SCREEN_WIDTH == 414 {
            imageFilePath = NSBundle.mainBundle().pathForResource("VIP_Privilege@2x.png", ofType: nil)!
        }else{
            imageFilePath = NSBundle.mainBundle().pathForResource("VIP_Privilege@3x.png", ofType: nil)!
        }
        let vipBackgroundImage = UIImage(contentsOfFile: imageFilePath)
        vipBackgroundImageView = UIImageView(image: vipBackgroundImage)
        vipBackgroundImageView.contentMode = .ScaleAspectFill
        self.view.addSubview(vipBackgroundImageView)
        
        verifyButton = UIButton()
        verifyButton.setBackgroundImage(UIImage(named: "btn_big"), forState: .Normal)
        verifyButton.setTitle("立即认证", forState: .Normal)
        verifyButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        verifyButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        verifyButton.addTarget(self, action: #selector(self.tapVerifyButton), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(verifyButton)
        
        knowMoreButton = UIButton()
        knowMoreButton.setTitle("了解详细大V特权 >", forState: .Normal)
        knowMoreButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        knowMoreButton.titleLabel?.font = UIFont.systemFontOfSize(13)
        self.view.addSubview(knowMoreButton)
    }
    
    private func setupConstraints(){
        welcomeLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(64 + 8)
        }
        
        vipBackgroundImageView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(welcomeLabel.snp_bottom).offset(12)
            make.width.equalTo(self.view).multipliedBy(650.0 / 750.0)
            make.height.equalTo(self.view).multipliedBy(911.0 / 1334.0)
        }
        
        verifyButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(vipBackgroundImageView.snp_bottom).offset(-10)
            make.size.equalTo(CGSize(width: 192, height: 50))
        }
        
        knowMoreButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(verifyButton.snp_bottom).offset(15)
        }
        
    }
    
    private func setupGradientBackground(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        self.view.layer .addSublayer(gradientLayer)
        
        gradientLayer.colors = [UIColor(hex: 0xFF8560).CGColor, UIColor(hex: 0xFFA57D).CGColor]
        
        gradientLayer.startPoint = CGPoint(x: gradientLayer.frame.size.width / 2, y: 0)
        gradientLayer.endPoint   = CGPoint(x: gradientLayer.frame.size.width / 2, y: gradientLayer.frame.size.height)
        
    }
    
    private func setupNavBar(){
        self.navigationController?.navigationBar.lt_setBackgroundColor(UIColor(hex: 0xFF8560))
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
    }
    
    
    // MARK: Target-actions
    
    func tapVerifyButton(){
        self.navigationController?.pushViewController(PPVIPSignupViewController(), animated: true)
    }
    
    func tapKnowMoreButton(){
        HUD.flash(.Label("KnowMoreButton"))
    }

}
