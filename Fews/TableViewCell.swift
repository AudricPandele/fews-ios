//
//  TableViewCell.swift
//  Fews
//
//  Created by Audric Pandelé on 27/01/2016.
//  Copyright © 2016 Audric Pandelé. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    var event: Event!

    @IBOutlet weak var collectionView: UICollectionView!

}

extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MapCell", forIndexPath: indexPath)
        (cell as! MapCollectionViewCell).layer.borderColor = UIColor.FewsGreyBorderColor().CGColor
        (cell as! MapCollectionViewCell).layer.borderWidth = 1
        (cell as! MapCollectionViewCell).layer.cornerRadius = 5
        (cell as! MapCollectionViewCell).location = self.event.location
        
        return cell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath.row)")
    }
}

