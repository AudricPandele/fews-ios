//
//  GalleryTableViewCell.swift
//  Fews
//
//  Created by Audric Pandelé on 01/02/2016.
//  Copyright © 2016 Audric Pandelé. All rights reserved.
//

import UIKit

class GalleryCollectionView: UITableViewCell {
    var images: [String]!

    @IBOutlet weak var galleryCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension GalleryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GalleryCell", forIndexPath: indexPath)
        
        if let url = NSURL(string: images[indexPath.row]) {
            (cell as! GalleryCollectionViewCell).imageView.hnk_setImageFromURL(url)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

    }
    
}