//
//  PPRoundView.swift
//  live
//
//  Created by chenpeiwei on 3/21/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPRoundView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.width*0.5
        self.clipsToBounds = true
    }
}
