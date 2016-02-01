//
//  WikiCollectionViewCell.swift
//  Fews
//
//  Created by Audric Pandelé on 20/01/2016.
//  Copyright © 2016 Audric Pandelé. All rights reserved.
//

import UIKit

class WikiCollectionViewCell: UICollectionViewCell {
    var url: String!
    
    @IBAction func openURL(sender: AnyObject) {
        if let link = NSURL(string: url) {
            UIApplication.sharedApplication().openURL(link)
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
}
