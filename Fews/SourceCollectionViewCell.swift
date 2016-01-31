//
//  SourceCollectionViewCell.swift
//  Fews
//
//  Created by Audric Pandelé on 31/01/2016.
//  Copyright © 2016 Audric Pandelé. All rights reserved.
//

import UIKit

class SourceCollectionViewCell: UICollectionViewCell {
    var url: String!
    
    @IBOutlet weak var sourceImageView: UIImageView!
    
    @IBAction func openURL(sender: UIButton) {
        if let link = NSURL(string: url) {
            UIApplication.sharedApplication().openURL(link)
        }
    }
    
}
