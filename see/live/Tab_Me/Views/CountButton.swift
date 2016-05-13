//
//  CountButton.swift
//  vision_demo
//
//  Created by TUPAI-Huangwei on 3/15/16.
//  Copyright © 2016 TUPAI-Huangwei. All rights reserved.
//

import UIKit

class CountButton: UIView {
    @IBOutlet weak var numberCountLabel: UILabel!
    
    @IBOutlet weak var typeStr: UILabel!
    
    override init(frame: CGRect){
        super.init(frame:frame)
        setupSubviews()
    }
    
    convenience init(){
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    func setupSubviews(){
        let view   = loadViewFromNib()
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView{
        let nib  = UINib(nibName: "CountButton", bundle: nil)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
}
