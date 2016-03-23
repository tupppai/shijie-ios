//
//  PPGiftView.swift
//  vision_demo
//
//  Created by TUPAI-Huangwei on 3/21/16.
//  Copyright © 2016 TUPAI-Huangwei. All rights reserved.
//

import UIKit
import SnapKit

private struct Constants{
    static let cellIdentifier     = "PPGiftCell"
    static let toolBarHeight      = 50
    static let giftViewCellWidth  = Int(ceil(UIScreen.mainScreen().bounds.width / 4.0)) - 5
    static let giftViewCellHeight = giftViewCellWidth + 20
    static let giftViewHeight     = 2 * giftViewCellHeight
}

protocol PPGiftViewDelegate: class{
    func giftViewDidChargeMoney(giftView: PPGiftView)
    func giftViewDidSendDiamond(giftView: PPGiftView, model: PPGiftModel)
}

class PPGiftView: UIView {
    weak var delegate: PPGiftViewDelegate?
    
    private var giftCollectionView: PPGiftCollectionView?
    
    private var giftViewTopConstraint: Constraint? = nil
    
    private var giftViewToolbar: PPGiftViewToolBar?
    
    private var selectedIndexPath: NSIndexPath?
    
    private lazy var giftModels : [PPGiftModel] = {
        var array = [PPGiftModel](count: 50, repeatedValue: PPGiftModel(imageName: "avatar_example", diamondCount: 22, experienceCount: 344, selected: false))
        return array
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    convenience init(){
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: public methods
    func show(){
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
        self.layoutIfNeeded()
        
        let giftViewContainerHeight = Constants.giftViewHeight + Constants.toolBarHeight
        
        giftViewTopConstraint?.updateOffset(-giftViewContainerHeight)
        
        UIView.animateWithDuration(0.2) { () -> Void in
            self.layoutIfNeeded()
            self.backgroundColor = UIColor(hex: 0x000000, alpha: 0.8)
        }
    }
    
    func show(inView: UIView){
        inView.addSubview(self)
        self.layoutIfNeeded()
        
        let giftViewContainerHeight = Constants.giftViewHeight + Constants.toolBarHeight
        
        giftViewTopConstraint?.updateOffset(-giftViewContainerHeight)

        UIView.animateWithDuration(0.2) { () -> Void in
            self.layoutIfNeeded()
            self.backgroundColor = UIColor(hex: 0x000000, alpha: 0.8)
        }
    }
    
    func dismiss(){
        
        giftViewTopConstraint?.updateOffset(0)

        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.layoutIfNeeded()

            self.backgroundColor = UIColor(hex: 0x000000, alpha: 0.0)
            }) { (finished) -> Void in
                if finished{
                    self.removeFromSuperview()
                }
        }
        
        guard selectedIndexPath != nil else{
            return
        }
        
        giftCollectionView?.deselectItemAtIndexPath(selectedIndexPath!, animated: false)
        selectedIndexPath = nil
    }
    
    // MARK: private helpers
    private func commonInit(){
        self.frame = UIScreen.mainScreen().bounds
//        self.backgroundColor = UIColor(hexString: "000000", alpha: 0.0)
        self.backgroundColor = UIColor(hex: 0x00000, alpha: 0.0)
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("tapOnSelf:"))
        self.addGestureRecognizer(tap)
        tap.delegate = self
        
        // --- ContainerView
        let giftViewContainerView = UIView()
        self.addSubview(giftViewContainerView)
        giftViewContainerView.snp_makeConstraints { [weak self] (make) -> Void in
            make.left.right.equalTo(self!)
            self!.giftViewTopConstraint =
            make.top.equalTo((self?.snp_bottom)!).constraint
            make.height.equalTo(Constants.giftViewHeight + Constants.toolBarHeight)
        }
        
        // --- Gift CollectionView
        let layout = HorizontalCollectionViewLayout(width: Constants.giftViewCellWidth, height: Constants.giftViewCellHeight)
        
        giftCollectionView = PPGiftCollectionView(frame: CGRectZero, collectionViewLayout: layout)
        giftCollectionView!.dataSource = self
        giftCollectionView!.delegate   = self
        giftCollectionView?.registerNib(UINib(nibName: Constants.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: Constants.cellIdentifier)
        giftViewContainerView.addSubview(giftCollectionView!)
        giftCollectionView?.snp_makeConstraints(closure: { (make) -> Void in
            make.top.left.right.equalTo(giftViewContainerView)
            make.height.equalTo(Constants.giftViewHeight)
        })
        
        // --- Gift ToolBar
        giftViewToolbar = PPGiftViewToolBar.toolBar()
        giftViewToolbar?.delegate = self
        giftViewContainerView.addSubview(giftViewToolbar!)
        giftViewToolbar!.snp_makeConstraints { (make) -> Void in
            make.top.equalTo((giftCollectionView?.snp_bottom)!)
            make.left.right.equalTo(giftViewContainerView)
            make.height.equalTo(Constants.toolBarHeight)
        }
    }
    
    // MARK: Target-action
    func tapOnSelf(recognizer: UITapGestureRecognizer){
        if self.hitTest(recognizer.locationInView(self), withEvent: nil) === self{
            dismiss()
        }
    }
    
}

extension PPGiftView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return giftModels.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Constants.cellIdentifier, forIndexPath: indexPath) as! PPGiftCell
        
        let giftModel = giftModels[indexPath.row]
        cell.bindModel(giftModel)
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if selectedIndexPath != nil && selectedIndexPath == indexPath{
            collectionView.deselectItemAtIndexPath(indexPath, animated: true)
            selectedIndexPath = nil
            return
        }
        selectedIndexPath = indexPath
    }
}

extension PPGiftView: PPGiftViewToolBarDelegate{
    func toolBarDidCharge(toolBar: PPGiftViewToolBar) {
        delegate?.giftViewDidChargeMoney(self)
    }
    
    func toolBarDidSendDiamond(toolBar: PPGiftViewToolBar) {
        guard selectedIndexPath != nil else{
            print("还没有选给多少钻石")
            return
        }
        delegate?.giftViewDidSendDiamond(self, model: giftModels[selectedIndexPath!.row])
    }
}

extension PPGiftView: UIGestureRecognizerDelegate{
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        let location = gestureRecognizer.locationInView(giftCollectionView)
        if giftCollectionView!.layer.containsPoint(location){
            return false
        }else{
            return true
        }
    }
}