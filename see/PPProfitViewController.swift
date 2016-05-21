//
//  PPProfitViewController.swift
//  see
//
//  Created by TUPAI-Huangwei on 16/5/21.
//  Copyright © 2016年 pires.inc. All rights reserved.
//

import UIKit

class PPProfitViewController: UIViewController {

    private var profitStatisticsView: PPProfitStatisticsView!
    
    private var exchangeButton: UIButton!
    
    private var wechatWithdrawButton: UIButton!
    
    private var faqButton: UIButton!
    
    // MARK: UI life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()
        setupSubviews()
        setupConstraints()
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


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UI setup
    private func setupSubviews(){
        profitStatisticsView = PPProfitStatisticsView(frame:  CGRect(x: 0, y: 64, width: ScreenSize.SCREEN_WIDTH, height: 210))
        self.view.addSubview(profitStatisticsView)
        
        exchangeButton = UIButton()
        exchangeButton.setTitle("兑换", forState: .Normal)
        exchangeButton.setBackgroundImage(UIImage(named: "btn_orange_40pxH"), forState: .Normal)
        exchangeButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        exchangeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.view.addSubview(exchangeButton)
        
        wechatWithdrawButton = UIButton()
        wechatWithdrawButton.setTitle("微信兑换", forState: .Normal)
        wechatWithdrawButton.setTitleColor(UIColor(hex: 0x000000, alpha: 0.6), forState: .Normal)
        wechatWithdrawButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        wechatWithdrawButton.setBackgroundImage(UIImage(named: "btn_white_40pxH"), forState: .Normal)
        self.view.addSubview(wechatWithdrawButton)
        
        faqButton = UIButton()
        faqButton.setTitleColor(UIColor(hex: 0x000000, alpha: 0.5), forState: .Normal)
        faqButton.setTitle("常见问题", forState: .Normal)
        faqButton.titleLabel?.font = UIFont.systemFontOfSize(11)
        self.view.addSubview(faqButton)
    }
    
    private func setupConstraints(){
        faqButton.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.view).offset(-33)
            make.centerX.equalTo(self.view)
        }
        
        wechatWithdrawButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(faqButton.snp_top).offset(-60)
            make.size.equalTo(CGSize(width: 192, height: 50))
        }
        
        exchangeButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(wechatWithdrawButton.snp_top).offset(-14)
            make.size.equalTo(wechatWithdrawButton)
        }
        
    }
    
    private func setupNavBar(){
        self.navigationController?.navigationBar.lt_setBackgroundColor(UIColor(hex: 0xFA6421))
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }


}
