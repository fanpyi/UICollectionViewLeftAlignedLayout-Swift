//
//  UICollectionViewLeftAlignedLayout.swift
//  SwiftDemo
//
//  Created by fanpyi on 22/2/16.
//  Copyright © 2016 fanpyi. All rights reserved.
//  based on http://stackoverflow.com/questions/13017257/how-do-you-determine-spacing-between-cells-in-uicollectionview-flowlayout  https://github.com/mokagio/UICollectionViewLeftAlignedLayout

import UIKit
extension UICollectionViewLayoutAttributes {
    func leftAlignFrameWithSectionInset(sectionInset:UIEdgeInsets){
        var frame = self.frame
        frame.origin.x = sectionInset.left
        self.frame = frame
    }
}

class UICollectionViewLeftAlignedLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var attributesCopy: [UICollectionViewLayoutAttributes] = []
        if let attributes = super.layoutAttributesForElementsInRect(rect) {
            attributes.forEach({ attributesCopy.append($0.copy() as! UICollectionViewLayoutAttributes) })
        }
        
        for attributes in attributesCopy {
            if attributes.representedElementKind == nil {
                let indexpath = attributes.indexPath
                if let attr = layoutAttributesForItemAtIndexPath(indexpath) {
                    attributes.frame = attr.frame
                }
            }
        }
        return attributesCopy
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        if let currentItemAttributes = super.layoutAttributesForItemAtIndexPath(indexPath)?.copy() as? UICollectionViewLayoutAttributes {
            let sectionInset = self.evaluatedSectionInsetForItemAtIndex(indexPath.section)
            let isFirstItemInSection = indexPath.item == 0
            let layoutWidth = CGRectGetWidth(self.collectionView!.frame) - sectionInset.left - sectionInset.right
            
            if (isFirstItemInSection) {
                currentItemAttributes.leftAlignFrameWithSectionInset(sectionInset)
                return currentItemAttributes
            }
            
            let previousIndexPath = NSIndexPath(forItem: indexPath.item - 1, inSection: indexPath.section)
            
            let previousFrame = layoutAttributesForItemAtIndexPath(previousIndexPath)?.frame ?? CGRectZero
            let previousFrameRightPoint = previousFrame.origin.x + previousFrame.width
            let currentFrame = currentItemAttributes.frame
            let strecthedCurrentFrame = CGRectMake(sectionInset.left,
                                                   currentFrame.origin.y,
                                                   layoutWidth,
                                                   currentFrame.size.height)
            // if the current frame, once left aligned to the left and stretched to the full collection view
            // widht intersects the previous frame then they are on the same line
            let isFirstItemInRow = !CGRectIntersectsRect(previousFrame, strecthedCurrentFrame)
            
            if (isFirstItemInRow) {
                // make sure the first item on a line is left aligned
                currentItemAttributes.leftAlignFrameWithSectionInset(sectionInset)
                return currentItemAttributes
            }
            
            var frame = currentItemAttributes.frame
            frame.origin.x = previousFrameRightPoint + evaluatedMinimumInteritemSpacingForSectionAtIndex(indexPath.section)
            currentItemAttributes.frame = frame
            return currentItemAttributes
            
        }
        return nil
    }
    
    func evaluatedMinimumInteritemSpacingForSectionAtIndex(sectionIndex:Int) -> CGFloat {
        if let delegate = self.collectionView?.delegate as? UICollectionViewDelegateFlowLayout {
            if delegate.respondsToSelector(#selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:minimumInteritemSpacingForSectionAtIndex:))) {
                return delegate.collectionView!(self.collectionView!, layout: self, minimumInteritemSpacingForSectionAtIndex: sectionIndex)
                
            }
        }
        return self.minimumInteritemSpacing
        
    }
    
    func evaluatedSectionInsetForItemAtIndex(index: Int) ->UIEdgeInsets {
        if let delegate = self.collectionView?.delegate as? UICollectionViewDelegateFlowLayout {
            if  delegate.respondsToSelector(#selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:insetForSectionAtIndex:))) {
                return delegate.collectionView!(self.collectionView!, layout: self, insetForSectionAtIndex: index)
            }
        }
        return self.sectionInset
    }
}
