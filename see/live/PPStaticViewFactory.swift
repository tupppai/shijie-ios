//
//  PPShareViewFactory.swift
//  weika
//
//  Created by chenpeiwei on 4/12/16.
//  Copyright © 2016 weika.Inc. All rights reserved.
//

import UIKit

class PPStaticViewFactory: NSObject {
    static let shareInstance = PPStaticViewFactory()
//    static let spinner = PPStaticViewFactory.shareInstance.generateActivity()
//    
//    func generateActivity()-> UIActivityIndicatorView{
//        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
//        spinner.center = CGPoint(x: ScreenSize.SCREEN_WIDTH*0.5, y: ScreenSize.SCREEN_HEIGHT*0.5)
//        UIApplication.sharedApplication().keyWindow?.addSubview(spinner)
//        return spinner
//    }
//    
}



class PPSpinner:UIActivityIndicatorView {
    
    static let shareInstance = PPSpinner(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)

    override init(activityIndicatorStyle style: UIActivityIndicatorViewStyle) {
        super.init(activityIndicatorStyle: style)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func show() {
        self.startAnimating()
        
        guard let keywindow = UIApplication.sharedApplication().keyWindow else{
            return
        }
        if self.isDescendantOfView(keywindow) {
            return
        }

        self.center = CGPoint(x: ScreenSize.SCREEN_WIDTH*0.5, y: ScreenSize.SCREEN_HEIGHT*0.5)
        keywindow.addSubview(self)
    }
    
    func showInView(view:UIView) {
        self.startAnimating()
        if self.isDescendantOfView(view) {
            return
        }

        self.center = view.center
        view.insertSubview(self, atIndex: 0)
    }
    func dismiss() {
        self.stopAnimating()
        self.removeFromSuperview()
    }
}