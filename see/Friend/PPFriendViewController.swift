//
//  PPFriendViewController.swift
//  live
//
//  Created by TUPAI-Huangwei on 16/5/13.
//  Copyright © 2016年 Pires.Inc. All rights reserved.
//

import UIKit

private struct LayoutConstant{
    static let segmentedControlHeight = 65
    static let userHeaderViewHeight   = 298
    static let toolBarHeight          = 50
}

class PPFriendViewController: UIViewController {

    // MARK: Variables
    
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
        
        userheaderView = PPMeUserHeaderView(frame: CGRect(x: 0, y: 0, width: Int(ScreenSize.SCREEN_WIDTH), height: LayoutConstant.userHeaderViewHeight))
        
        segmentedControl = PPFriendSegmentedControlView(frame: CGRect(x:0, y:LayoutConstant.userHeaderViewHeight, width: Int(ScreenSize.SCREEN_WIDTH), height: LayoutConstant.segmentedControlHeight))
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: ScreenSize.SCREEN_WIDTH / 3 - 15, height: ScreenSize.SCREEN_WIDTH / 3 - 15)
        flowLayout.scrollDirection = .Vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        broadcastCollectionView =
            UICollectionView(frame: CGRect(x: 0, y:0, width: Int(ScreenSize.SCREEN_WIDTH), height: Int(ScreenSize.SCREEN_HEIGHT)), collectionViewLayout: flowLayout)
        broadcastCollectionView.dataSource = self
        broadcastCollectionView.delegate   = self
        broadcastCollectionView.registerClass(PPFriendBroadcastCollectionViewCell.self, forCellWithReuseIdentifier: broadcastCollectionViewCellIDentifier)
        broadcastCollectionView.backgroundColor = UIColor.whiteColor()
        
        broadcastCollectionView.contentInset = UIEdgeInsets(top: CGFloat(LayoutConstant.segmentedControlHeight) + CGFloat(LayoutConstant.userHeaderViewHeight) , left: 0, bottom: CGFloat(LayoutConstant.toolBarHeight), right: 0)
        
        toolbar = PPFriendActionToolbar(frame: CGRect(x:0, y:Int(ScreenSize.SCREEN_HEIGHT) - LayoutConstant.toolBarHeight , width: Int(ScreenSize.SCREEN_WIDTH), height: LayoutConstant.segmentedControlHeight))
        
        self.view.addSubview(broadcastCollectionView)
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
            userheaderView.frame = CGRect(x: 0,
                                          y: -LayoutConstant.userHeaderViewHeight,
                                          width: Int(ScreenSize.SCREEN_WIDTH),
                                          height: LayoutConstant.userHeaderViewHeight)
            
            
            segmentedControl.frame = CGRect(x: 0,
                                            y: 0,
                                            width: Int(ScreenSize.SCREEN_WIDTH),
                                            height: LayoutConstant.segmentedControlHeight)
            
        }else{
            // 跟着一起往下拉
            let segmentedControlY =
                (0.0 - offsetY) - CGFloat(LayoutConstant.segmentedControlHeight)
            
            let headerViewY = segmentedControlY - CGFloat(LayoutConstant.userHeaderViewHeight)
            
            segmentedControl.frame =
            CGRect(x: 0, y: Int(segmentedControlY),
                   width: Int(ScreenSize.SCREEN_WIDTH),
                   height: LayoutConstant.segmentedControlHeight)
            
            userheaderView.frame =
            CGRect(x: 0,
                   y: Int(headerViewY),
                   width: Int(ScreenSize.SCREEN_WIDTH),
                   height: LayoutConstant.userHeaderViewHeight)
            
        }
    }
    
}