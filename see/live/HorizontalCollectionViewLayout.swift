//
//  HorizontalCollectionViewLayout.swift
//  vision_demo
//
//  Created by TUPAI-Huangwei on 3/18/16.
//  Copyright © 2016 TUPAI-Huangwei. All rights reserved.
//

import UIKit

class HorizontalCollectionViewLayout: UICollectionViewLayout {
    
    var cellWidth: Int;
    var cellHeight: Int;
    
    init(width: Int, height: Int){
        cellWidth  = width
        cellHeight = height
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        cellWidth  = 0
        cellHeight = 0
        super.init(coder: aDecoder)
    }
    
    override func prepareLayout() {
        // Do nothing
    }
    
    override func collectionViewContentSize() -> CGSize {
        if cellsPerPage == 0{
            return CGSizeZero
        }
        let numberOfPages = Int(ceilf(Float(cellCount) / Float(cellsPerPage)))
        let width = numberOfPages * Int(boundsWidth)
        return CGSize(width: CGFloat(width), height: boundsHeight)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var allAttributes = [UICollectionViewLayoutAttributes]()
        
        for (var i = 0; i < cellCount; ++i) {
            let indexPath = NSIndexPath(forRow: i, inSection: 0)
            let attr = createLayoutAttributesForCellAtIndexPath(indexPath)
            allAttributes.append(attr)
        }
        return allAttributes
    }
    
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return createLayoutAttributesForCellAtIndexPath(indexPath)
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    private func createLayoutAttributesForCellAtIndexPath(indexPath:NSIndexPath)
        -> UICollectionViewLayoutAttributes {
            let layoutAttributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            layoutAttributes.frame = createCellAttributeFrame(indexPath.row)
            return layoutAttributes
    }
    
    
    private var boundsWidth:CGFloat {
        return self.collectionView!.bounds.size.width
    }
    
    private var boundsHeight:CGFloat {
        return self.collectionView!.bounds.size.height
    }
    
    private var cellCount:Int {
        return self.collectionView!.numberOfItemsInSection(0)
    }
    
    private var verticalCellCount:Int {
        return Int(floorf(Float(boundsHeight) / Float(cellHeight)))
    }
    
    private var horizontalCellCount:Int {
        return Int(floorf(Float(boundsWidth) / Float(cellWidth)))
    }
    
    private var cellsPerPage:Int {
        return verticalCellCount * horizontalCellCount
    }
    
    private func createCellAttributeFrame(row:Int) -> CGRect {
        let frameSize = CGSize(width: cellHeight, height: cellWidth)
        let frameX = calculateCellFrameHorizontalPosition(row)
        let frameY = calculateCellFrameVerticalPosition(row)
        return CGRectMake(frameX, frameY, frameSize.width, frameSize.height)
    }
    
    private func calculateCellFrameHorizontalPosition(row:Int) -> CGFloat {
        let columnPosition = row % horizontalCellCount
        let cellPage = Int(floorf(Float(row) / Float(cellsPerPage)))
        return CGFloat(cellPage * Int(round(boundsWidth)) + columnPosition * Int(cellWidth))
    }
    
    private func calculateCellFrameVerticalPosition(row:Int) -> CGFloat {
        let rowPosition = (row / horizontalCellCount) % verticalCellCount
        return CGFloat(rowPosition * Int(cellHeight))
    }
}
