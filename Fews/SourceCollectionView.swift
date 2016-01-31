//
//  SourceCollectionView.swift
//  Fews
//
//  Created by Audric Pandelé on 31/01/2016.
//  Copyright © 2016 Audric Pandelé. All rights reserved.
//

import UIKit

class SourceCollectionView: UITableViewCell {
    var articles: [Article]!

    @IBOutlet weak var sourceCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension SourceCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SourceCell", forIndexPath: indexPath)
        
        if let url = NSURL(string: articles[indexPath.row].logo) {
            (cell as! SourceCollectionViewCell).sourceImageView.hnk_setImageFromURL(url)
        }
        (cell as! SourceCollectionViewCell).url = articles[indexPath.row].link

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath.row)")
    }
}