//
//  ArticleTableViewController.swift
//  Fews
//
//  Created by Audric Pandelé on 15/12/2015.
//  Copyright © 2015 Audric Pandelé. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {

    var imageArticle: UIImage!
    var titleArticle: String!
    var textArticle: String!
    var textRowHeight: CGFloat!

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
        
        
        if cellIdentifier == "ImageCell" {
            (cell as! ImageCell).imageViewArticle.image = imageArticle
            (cell as! ImageCell).titleLabel.text = titleArticle
        }


        if cellIdentifier == "TextCell" {
            (cell as! TextCell).articleLabel.text = textArticle
            textRowHeight = (cell as! TextCell).articleLabel.frame.height
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableViewAutomaticDimension
        default: ()
        
        if (textRowHeight > 0.0){
            return textRowHeight + 20
        }else{
            return 200
            }
        }
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 200
        default: ()
        return 50
        }
    }
    
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    @IBAction func share(sender: AnyObject) {
        let textToShare = "I found that on Fews"
        
        if let myWebsite = NSURL(string: "url_of_event")
        {
            let objectsToShare = [textToShare, myWebsite]
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


