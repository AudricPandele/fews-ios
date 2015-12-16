//
//  ArticleTableViewController.swift
//  Fews
//
//  Created by Audric Pandelé on 15/12/2015.
//  Copyright © 2015 Audric Pandelé. All rights reserved.
//

import UIKit
import Haneke

class ArticleTableViewController: UITableViewController {

    var imageArticle: UIImage!
    var titleArticle: String!
    var textArticle: String!
    var event: Event!
    var textRowHeight: CGFloat! = 10

    override func viewWillAppear(animated: Bool) {
        tableView.contentOffset.y = 0.0
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        var cellIdentifier = ""
        switch indexPath.section {
        case 0:
            cellIdentifier = "ImageCell"
        case 1:
            cellIdentifier = "TextCell"
        default: ()
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        switch cellIdentifier {
        case "ImageCell":
                if let url = NSURL(string: self.event.top_image.original) {
                    (cell as! ImageCell).imageViewArticle.hnk_setImageFromURL(url)
                }
                (cell as! ImageCell).titleLabel.text = self.event.prepareArticleShortenTitle()
            
        case "TextCell":
                (cell as! TextCell).articleLabel.text = textArticle
                textRowHeight = (cell as! TextCell).articleLabel.frame.height
            
        default: ()
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 300
        case 1:
            return 200
        default: ()
        return 200
        }
    }
    
//    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        switch indexPath.section {
//        case 0:
//            return 200
//        default: ()
//        return 150
//        }
//    }
    
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    @IBAction func share(sender: AnyObject) {
        if let myWebsite = NSURL(string: "url_of_event")
        {
            let objectsToShare = [event.shareEvent(), myWebsite]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //New Excluded Activities Code
            activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]
            //
            
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
        
    }

    
    // MARK: - Scroll view delegate
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if let imageCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as? ImageCell {
            imageCell.scrollViewDidScroll(scrollView)
        }
    
        if scrollView.contentOffset.y <= -140 {
            self.dismissViewControllerAnimated(true, completion: {});

        }
    }
    
    
}


