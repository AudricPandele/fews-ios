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
    var storedOffsets = [Int: CGFloat]()
    
    override func viewWillAppear(animated: Bool) {
        tableView.contentOffset.y = 0.0
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    @IBAction func handleLongPress(sender: UILongPressGestureRecognizer) {
        let p: CGPoint = sender.locationInView(sender.view)
        sharing()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 7
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    // Comportement de chaque cellule du TableView
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        var cellIdentifier = ""
        switch indexPath.section {
        case 0:
            cellIdentifier = "ImageCell"
        case 1:
            cellIdentifier = "TextCell"
        case 2:
            cellIdentifier = "CitationCell"
        case 3:
            cellIdentifier = "TextCell2"
        case 4:
            cellIdentifier = "MapCollectionCell"
        case 5:
            cellIdentifier = "WikiCollectionCell"
        case 6:
            cellIdentifier = "TweetCollectionCell"
            
        default: ()
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        switch cellIdentifier {
        case "ImageCell":
            if let url = NSURL(string: self.event.top_image.original){
                (cell as! ImageCell).imageViewArticle.hnk_setImageFromURL(url)
            }
            (cell as! ImageCell).titleLabel.text = self.event.prepareArticleShortenTitle()
            
        case "TextCell":
            (cell as! TextCell).articleLabel.text = self.event.text[0]
            
        case "CitationCell":
            (cell as! CitationCell).CitationLabel.text = "\(self.event.quote)"
            (cell as! CitationCell).CitationLabel.font = UIFont(name: "HelveticaNeue-Italic", size: CGFloat(23))
            (cell as! CitationCell).CitationLabel.textColor = UIColor.FewsBlueColor()
            
        case "TextCell2":
            (cell as! TextCell).articleLabel.text = self.event.text[1]
            
        case "MapCollectionCell":
            (cell as! TableViewCell).event = self.event
            
        case "WikiCollectionCell":
            (cell as! WikiCollectionView).wikipedias = self.event.wikipedias

        case "TweetCollectionCell":
            (cell as! TweetCollectionView).tweets = self.event.tweets

        default: ()
        }
        
        return cell
    }
    
    // Taille de chaque cellule du TableView
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 300
        case 1:
            return 200
        case 2:
            return 120
        case 3:
            return 200
        case 4:
            return 215
        case 5:
            return 215
        case 6:
            return 215
        default: ()
        return 200
        }
    }
    
    
    // Fermer en scollant vers le bas
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if let imageCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as? ImageCell {
            imageCell.scrollViewDidScroll(scrollView)
            
            if scrollView.contentOffset.y >= 50 {
                if let url = NSURL(string: self.event.top_image.low){
                    imageCell.imageViewArticle?.hnk_setImageFromURL(url)
                }
                let t: CGFloat = (50/scrollView.contentOffset.y)
                imageCell.titleLabel.alpha = t
                if t <= 0.25 {
                    imageCell.titleLabel.hidden = true
                } else {
                    imageCell.titleLabel.hidden = false
                }
            } else {
                if let url = NSURL(string: self.event.top_image.original){
                    imageCell.titleLabel.alpha = 1
                    imageCell.imageViewArticle?.hnk_setImageFromURL(url)
                }
            }
        }
        
        if scrollView.contentOffset.y >= 257 {
            self.navigationController?.navigationBar.backgroundColor = UIColor.FewsGreyBlackColor()
            self.navigationController?.navigationBar.translucent = true
            self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
            self.title = self.event.dateToString(false).uppercaseString
            
        } else {
            self.navigationController?.navigationBar.backgroundColor = UIColor.clearColor()
            self.navigationController?.navigationBar.translucent = true
            self.title = ""
        }
        
        if scrollView.contentOffset.y <= -140 {
            self.dismissViewControllerAnimated(true, completion: {});
            
        }
    }
    
    
    // Fonctions custom
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    func sharing(){
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
    
    @IBAction func share(sender: AnyObject) {
        sharing()
    }
    
}
