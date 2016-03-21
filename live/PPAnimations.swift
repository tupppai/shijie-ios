//
//  PPAnimations.swift
//  live
//
//  Created by chenpeiwei on 3/21/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import Foundation

extension SpringView {
    
    /**
     designated to show  "user detail panel view "
     */
    func slideUpAnimate() {
        self.animation = "slideUp"
        self.curve = "easeOut"
        self.duration = 0.3
        self.scaleX = 1.01
        self.scaleY = 1.01
        self.damping = 1.0
        self.velocity = 0
        self.animate()
    }
}