//
//  PPMyLevelViewController.swift
//  see
//
//  Created by TUPAI-Huangwei on 16/5/20.
//  Copyright © 2016年 pires.inc. All rights reserved.
//

import UIKit

class PPMyLevelViewController: UIViewController {
    
    private var containerScrollView: UIScrollView!
    
    private var myLevelBadgeView: PPMyLevelBadgeView!
    
    private var myLevelDescView: PPMyLevelDescView!
    
    // MARK: UI life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
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
        containerScrollView = UIScrollView()
        containerScrollView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(containerScrollView)
        
        myLevelBadgeView = PPMyLevelBadgeView()
        containerScrollView.addSubview(myLevelBadgeView)
        
        myLevelDescView = PPMyLevelDescView()
        containerScrollView.addSubview(myLevelDescView)
    }
    
    private func setupConstraints(){
        containerScrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        myLevelBadgeView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(containerScrollView)
            make.width.equalTo(ScreenSize.SCREEN_WIDTH)
            make.height.equalTo(220)
        }
        
        myLevelDescView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(containerScrollView)
            make.top.equalTo(myLevelBadgeView.snp_bottom).offset(10)
        }
    }
    
    private func setupNavBar(){
        self.navigationController?.navigationBar.lt_setBackgroundColor(UIColor(hex: 0xFF8560))
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        
    }
}
