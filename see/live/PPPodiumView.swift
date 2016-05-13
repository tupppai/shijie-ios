//
//  PPPodiumView.swift
//  live
//
//  Created by TUPAI-Huangwei on 3/23/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPPodiumView: UIView {

    var firstThreeUsers:[PPUserModel_toremove]
    
    override init(frame: CGRect){
        firstThreeUsers = []
        super.init(frame: frame)
        setupSubviews()
    }
    
    convenience init(firstThreeUsers: [PPUserModel_toremove]){
        self.init(frame: CGRect.zero)
        self.firstThreeUsers = firstThreeUsers
    }
    
    required init?(coder aDecoder: NSCoder) {
        firstThreeUsers = []
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    private func setupSubviews(){

        self.backgroundColor = UIColor(hex: 0xF96520)
        
        let podiumBackgroundImageView = UIImageView(image: UIImage(named: "podium_background"))
        self.addSubview(podiumBackgroundImageView)
        podiumBackgroundImageView.snp_makeConstraints { [weak self] (make) -> Void in
            make.edges.equalTo(self!)
        }
        
        // three container view for properly laying out podiumUserViews
        // 三个containerView三等分
        let containerView1 = UIView()
        let containerView2 = UIView()
        let containerView3 = UIView()
        
        containerView1.backgroundColor = UIColor.clearColor()
        containerView2.backgroundColor = UIColor.clearColor()
        containerView3.backgroundColor = UIColor.clearColor()
        
        self.addSubview(containerView1)
        self.addSubview(containerView2)
        self.addSubview(containerView3)
        
        containerView1.snp_makeConstraints { [weak self] (make) -> Void in
            make.top.left.bottom.equalTo(self!)
        }
        
        containerView2.snp_makeConstraints { [weak self] (make) -> Void in
            make.top.bottom.equalTo(self!)
            make.size.equalTo(containerView1.snp_size)
            make.left.equalTo(containerView1.snp_right)
        }
        
        containerView3.snp_makeConstraints { [weak self] (make) -> Void in
            make.top.right.bottom.equalTo(self!)
            make.size.equalTo(containerView2.snp_size)
            make.left.equalTo(containerView2.snp_right)
        }
        
        
        // containerView的顺序是从左到右的，但是第一名的用户是放在正中间 
        let podiumUserView1 = PPPodiumUserView()
        podiumUserView1.rank = 1
        containerView2.addSubview(podiumUserView1)
        podiumUserView1.snp_makeConstraints {  (make) -> Void in
            make.size.equalTo(CGSize(width: 86, height: 135))
            make.centerX.equalTo(containerView2)
            make.centerY.equalTo(containerView2).offset(-15)
        }
        
        let podiumUserView2 = PPPodiumUserView()
        podiumUserView2.rank = 2
        containerView1.addSubview(podiumUserView2)
        podiumUserView2.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSize(width: 86, height: 135))
            make.centerX.equalTo(containerView1)
            make.centerY.equalTo(containerView1).offset(20)
        }
        
        let podiumUserView3 = PPPodiumUserView()
        podiumUserView3.rank = 3
        containerView3.addSubview(podiumUserView3)
        podiumUserView3.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSize(width: 86, height: 135))
            make.centerX.equalTo(containerView3)
            make.centerY.equalTo(containerView3).offset(20)
        }

    }
}
