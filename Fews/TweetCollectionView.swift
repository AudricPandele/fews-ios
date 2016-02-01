//
//  TweetCollectionView.swift
//  Fews
//
//  Created by Audric Pandelé on 28/01/2016.
//  Copyright © 2016 Audric Pandelé. All rights reserved.
//

import UIKit

class TweetCollectionView: UITableViewCell {
    var tweets: [TweetObject]!
    
    @IBOutlet weak var tweetCollectionView: UICollectionView!
}

extension TweetCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TweetCell", forIndexPath: indexPath)
        (cell as! TweetCollectionViewCell).layer.borderColor = UIColor.FewsTwitterColor().CGColor
        (cell as! TweetCollectionViewCell).layer.borderWidth = 1
        (cell as! TweetCollectionViewCell).layer.cornerRadius = 5
        (cell as! TweetCollectionViewCell).username_label.textColor = UIColor.FewsTwitterColor()
        (cell as! TweetCollectionViewCell).username_label.text = tweets[indexPath.row].user_name
        (cell as! TweetCollectionViewCell).nameLabel.textColor = UIColor.FewsTwitterColor()
        (cell as! TweetCollectionViewCell).nameLabel.text = tweets[indexPath.row].name
        (cell as! TweetCollectionViewCell).textLabel.text = tweets[indexPath.row].text
        (cell as! TweetCollectionViewCell).url = tweets[indexPath.row].link
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath.row)")
    }
}

