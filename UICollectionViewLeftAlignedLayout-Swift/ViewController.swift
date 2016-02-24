//
//  ViewController.swift
//  CollectionViewAlignLeftDemo
//
//  Created by fanpyi on 23/2/16.
//  Copyright © 2016 fanpyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let kCellIdentifier = "kCellIdentifier"
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(UICollectionViewCell.self , forCellWithReuseIdentifier: kCellIdentifier)
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: collectionView, selector: "reloadData", userInfo: nil, repeats: true)
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 20 :80
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellIdentifier, forIndexPath: indexPath)
        
        cell.contentView.layer.borderColor = UIColor.grayColor().CGColor
        cell.contentView.layer.borderWidth = 2;
        return cell;
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let  randomWidth = (arc4random() % 120) + 60;
        return CGSizeMake(CGFloat(randomWidth), 60);
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return section == 0 ? 15 :5
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

