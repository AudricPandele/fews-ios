//
//  TweetCollectionViewCell.swift
//  Fews
//
//  Created by Audric Pandelé on 28/01/2016.
//  Copyright © 2016 Audric Pandelé. All rights reserved.
//

import UIKit

class TweetCollectionViewCell: UICollectionViewCell {
    var url: String!
    
    @IBAction func openURL(sender: AnyObject) {
        if let link = NSURL(string: url) {
            UIApplication.sharedApplication().openURL(link)
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var username_label: UILabel!
    @IBOutlet weak var textLabel: UILabel!
}
