//
//  PPTabBarController.swift
//  live
//
//  Created by chenpeiwei on 3/8/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit
class PPTabBarController: UITabBarController,UITabBarControllerDelegate {

    private var temporaryCenterViewController:UIViewController!
    private var vc1:PPLiveListViewController = PPLiveListViewController()
    private var vc3:PPMeTableViewController = PPMeTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.tabBar.barTintColor = UIColor.whiteColor()
        self.tabBar.setValue(true, forKey: "_hidesShadow")
        
        delegate = self;
        temporaryCenterViewController = UIViewController()
        temporaryCenterViewController.view.backgroundColor = UIColor.redColor()
        vc3.view.backgroundColor = UIColor.grayColor()
        
        let navigationController1 = UINavigationController(rootViewController: vc1)
        let navigationController3 = UINavigationController(rootViewController: vc3)
        
        vc1.tabBarItem.image = UIImage(named: "tab1")?.imageWithRenderingMode(.AlwaysOriginal)
        vc1.tabBarItem.selectedImage = UIImage(named: "tab1-selected")?.imageWithRenderingMode(.AlwaysOriginal)
        temporaryCenterViewController.tabBarItem.image = UIImage(named: "tab2")?.imageWithRenderingMode(.AlwaysOriginal)
        vc3.tabBarItem.image = UIImage(named: "tab3")?.imageWithRenderingMode(.AlwaysOriginal)

        vc3.tabBarItem.selectedImage = UIImage(named: "tab3-selected")?.imageWithRenderingMode(.AlwaysOriginal)

        vc1.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        temporaryCenterViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        vc3.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)

//        _navigationPlaceholder_center.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);


        self.viewControllers = [navigationController1,temporaryCenterViewController,navigationController3]
        
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if viewController === temporaryCenterViewController {
            let launchLiveVC = PPLaunchLiveViewController()
            
            /*
             http://stackoverflow.com/questions/18902059/ios-semi-transparent-modal-view-controller
             */
            launchLiveVC.modalPresentationStyle = .OverFullScreen
            
            
            self.presentViewController(launchLiveVC, animated: true, completion: nil)
            return false
        }
        return true
    }
    
}
