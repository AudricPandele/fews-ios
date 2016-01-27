//
//  WikiCollectionView.swift
//  Fews
//
//  Created by Audric Pandelé on 27/01/2016.
//  Copyright © 2016 Audric Pandelé. All rights reserved.
//

import UIKit

class WikiCollectionView: UITableViewCell {
    var wikipedias: [WikipediaObject]!

    @IBOutlet weak var wikiCollectionView: UICollectionView!
    
}

extension WikiCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wikipedias.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("WikiCell", forIndexPath: indexPath)
        (cell as! WikiCollectionViewCell).layer.borderColor = UIColor.FewsGreyBorderColor().CGColor
        (cell as! WikiCollectionViewCell).layer.borderWidth = 1
        (cell as! WikiCollectionViewCell).layer.cornerRadius = 5
        (cell as! WikiCollectionViewCell).titleLabel.text = wikipedias[indexPath.row].name
        (cell as! WikiCollectionViewCell).textLabel.text = wikipedias[indexPath.row].text
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath.row)")
    }
}

