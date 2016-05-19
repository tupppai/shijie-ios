//
//  PPFriendViewController.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/13.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit
import PKHUD

private struct LayoutConstant{
    static let statusBarHeight        = 20
    static let fakeNavBarHeight       = 44
    static let segmentedControlHeight = 65
    static let userHeaderViewHeight   = 298
    static let toolBarHeight          = 50
}

class PPFriendViewController: UIViewController {
    // MARK: Variables
    
    private var fakeNavBar: PPFakeNavigationBar!
    
    private var toolbar: PPFriendActionToolbar!
    
    private var segmentedControl: PPFriendSegmentedControlView!
    
    private var broadcastCollectionView: UICollectionView!
    
    private var userheaderView: PPMeUserHeaderView!
    
    private let broadcastCollectionViewCellIDentifier = "BroadcastCollectionViewCellIDentifier"
    
    // MARK: UI life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        
        setupSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: setup UI
    private func setupSubviews(){
        
        // --- 假的navigationbar，
        let fakeNavBarX = CGFloat(0)
        let fakeNavBarY = CGFloat(LayoutConstant.statusBarHeight)
        let fakeNavBarW = ScreenSize.SCREEN_WIDTH
        let fakeNavBarH = CGFloat(LayoutConstant.fakeNavBarHeight)
        fakeNavBar = PPFakeNavigationBar(frame: CGRect(x: fakeNavBarX, y: fakeNavBarY, width: fakeNavBarW, height: fakeNavBarH))
        fakeNavBar.delegate = self
        
        // --- 用户headerView
        let userHeaderViewX = CGFloat(0)
        let userHeaderViewY = CGRectGetMaxY(fakeNavBar.frame)
        let userHeaderViewW = ScreenSize.SCREEN_WIDTH
        let userHeaderViewH = CGFloat(LayoutConstant.userHeaderViewHeight)
        userheaderView = PPMeUserHeaderView(frame: CGRect(x: userHeaderViewX, y: userHeaderViewY, width: userHeaderViewW, height: userHeaderViewH))
        
        // --- segmentedControl
        let segmentedControlX = CGFloat(0)
        let segmentedControlY = CGRectGetMaxY(userheaderView.frame)
        let segmentedControlW = ScreenSize.SCREEN_WIDTH
        let segmentedControlH = CGFloat(LayoutConstant.segmentedControlHeight)
        segmentedControl = PPFriendSegmentedControlView(frame: CGRect(x: segmentedControlX, y: segmentedControlY, width: segmentedControlW, height: segmentedControlH))
        
        // --- collectionView
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: ScreenSize.SCREEN_WIDTH / 3 - 6, height: ScreenSize.SCREEN_WIDTH / 3 - 6)
        flowLayout.scrollDirection         = .Vertical
        flowLayout.minimumLineSpacing      = 3
        flowLayout.minimumInteritemSpacing = 3
        flowLayout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        
        
        let broadcastCollectionViewX = CGFloat(0)
        let broadcastCollectionViewY = CGFloat(0)
        let broadcastCollectionViewW = ScreenSize.SCREEN_WIDTH
        let broadcastCollectionViewH = ScreenSize.SCREEN_HEIGHT
        
        broadcastCollectionView =
            UICollectionView(frame: CGRect(x: broadcastCollectionViewX, y:broadcastCollectionViewY, width: broadcastCollectionViewW, height: broadcastCollectionViewH) , collectionViewLayout: flowLayout)
        broadcastCollectionView.dataSource = self
        broadcastCollectionView.delegate   = self
        broadcastCollectionView.registerClass(PPFriendBroadcastCollectionViewCell.self, forCellWithReuseIdentifier: broadcastCollectionViewCellIDentifier)
        broadcastCollectionView.backgroundColor = UIColor.whiteColor()
        
        broadcastCollectionView.setContentOffset(CGPoint(x: 0, y: -400), animated: true)
        
        let contentInsetTop =
            CGFloat(LayoutConstant.statusBarHeight +
                LayoutConstant.fakeNavBarHeight +
                LayoutConstant.userHeaderViewHeight +
                LayoutConstant.segmentedControlHeight)
        let contentInsetBottom = CGFloat(LayoutConstant.toolBarHeight)
        
        broadcastCollectionView.contentInset = UIEdgeInsets(top: contentInsetTop, left: 0, bottom: contentInsetBottom, right: 0)
        
        // --- 底层工具栏
        let toolbarX = CGFloat(0)
        let toolbarY = ScreenSize.SCREEN_HEIGHT - CGFloat(LayoutConstant.toolBarHeight)
        let toolbarW = ScreenSize.SCREEN_WIDTH
        let toolbarH = CGFloat(LayoutConstant.toolBarHeight)
        toolbar = PPFriendActionToolbar(frame: CGRect(x:toolbarX, y:toolbarY, width: toolbarW, height: toolbarH))
        toolbar.delegate = self
        
        /* 注意subviews的添加次序！有讲究的！ */
        self.view.addSubview(broadcastCollectionView)
        self.view.addSubview(fakeNavBar)
        self.view.addSubview(userheaderView)
        self.view.addSubview(segmentedControl)
        self.view.addSubview(toolbar)
    }
    
}

extension PPFriendViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(broadcastCollectionViewCellIDentifier, forIndexPath: indexPath) as! PPFriendBroadcastCollectionViewCell
        
        // cell model-view binding ...
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if (0.0 - offsetY) < CGFloat(LayoutConstant.segmentedControlHeight) {
            // 被顶上去了，只有segmentedControlView定在最上面
            
            let fakeNavBarX = CGFloat(0)
            let fakeNavBarY = -CGFloat(LayoutConstant.fakeNavBarHeight + LayoutConstant.userHeaderViewHeight)
            let fakeNavBarW = ScreenSize.SCREEN_WIDTH
            let fakeNavBarH = CGFloat(LayoutConstant.fakeNavBarHeight)
            
            fakeNavBar.frame = CGRect(x: fakeNavBarX,
                                      y: fakeNavBarY,
                                      width: fakeNavBarW,
                                      height: fakeNavBarH)
            
            let userheaderViewX = CGFloat(0)
            let userheaderViewY = -CGFloat(LayoutConstant.userHeaderViewHeight)
            let userheaderViewW = ScreenSize.SCREEN_WIDTH
            let userheaderViewH = CGFloat(LayoutConstant.userHeaderViewHeight)
            
            userheaderView.frame = CGRect(x: userheaderViewX,
                                          y: userheaderViewY,
                                          width: userheaderViewW,
                                          height: userheaderViewH)
            
            
            let segmentedControlX = CGFloat(0)
            let segmentedControlY = CGFloat(0)
            let segmentedControlW = ScreenSize.SCREEN_WIDTH
            let segmentedControlH = CGFloat(LayoutConstant.segmentedControlHeight)
            
            segmentedControl.frame = CGRect(x: segmentedControlX,
                                            y: segmentedControlY,
                                            width: segmentedControlW,
                                            height:segmentedControlH)
        }else{
            // 跟着一起往下拉
            let segmentedControlY =
                (0.0 - offsetY) - CGFloat(LayoutConstant.segmentedControlHeight)
            
            let headerViewY = segmentedControlY - CGFloat(LayoutConstant.userHeaderViewHeight)
            
            let fakeNavBarY = headerViewY - CGFloat(LayoutConstant.fakeNavBarHeight)
            
            segmentedControl.frame =
                CGRect(x: 0, y: segmentedControlY,
                       width: ScreenSize.SCREEN_WIDTH,
                       height: CGFloat(LayoutConstant.segmentedControlHeight))
            
            userheaderView.frame =
                CGRect(x: 0,
                       y: headerViewY,
                       width: ScreenSize.SCREEN_WIDTH,
                       height: CGFloat(LayoutConstant.userHeaderViewHeight))
            
            fakeNavBar.frame =
                CGRect(x: 0, y: fakeNavBarY, width: ScreenSize.SCREEN_WIDTH, height: CGFloat(LayoutConstant.fakeNavBarHeight))
        }
    }
    
}

extension PPFriendViewController: PPFakeNaivgationBarDelegate{
    func fakeNavigationBar(navBar: PPFakeNavigationBar, didTapButton buttonType: PPFakeNavigationBarButtonType) {
        switch buttonType {
        case .Back:
            self.dismissViewControllerAnimated(true, completion: nil)
        case .OnLive:
            HUD.flash(.Label("跳转: 直播界面"))
        case .More:
            HUD.flash(.Label("更多"))
        }
    }
}

extension PPFriendViewController: PPFriendActionToolbarDelegate{
    func toolbar(toolbar: PPFriendActionToolbar, didTapButton buttonType: PPFriendActionToolbarButtonType) {
        switch buttonType {
        case .Follow:
            HUD.flash(.Label("关注"))
        case .PrivateMessage:
            HUD.flash(.Label("私信"))
        case .BanUser:
            HUD.flash(.Label("屏蔽用户"))
        }
    }
}