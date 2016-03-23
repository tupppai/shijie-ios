//
//  PPPodiumView.swift
//  live
//
//  Created by TUPAI-Huangwei on 3/23/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPPodiumView: UIView {

    var firstThreeUsers:[PPUserModel]
    
    override init(frame: CGRect){
        firstThreeUsers = []
        super.init(frame: frame)
        setupSubviews()
    }
    
    convenience init(firstThreeUsers: [PPUserModel]){
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
        
        
        let podiumUserView = PPPodiumUserView()
        self.addSubview(podiumUserView)
        podiumUserView.snp_makeConstraints { [weak self] (make) -> Void in
            make.size.equalTo(CGSize(width: 86, height: 135))
            make.center.equalTo(self!)
        }
    }
}
