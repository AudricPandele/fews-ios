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
        UIApplication.sharedApplication().statusBarHidden = true;
    }

    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    @IBAction func handleLongPress(sender: UILongPressGestureRecognizer) {
        let p: CGPoint = sender.locationInView(sender.view)
        sharing()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
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
        case 2:
            cellIdentifier = "CitationCell"
        case 3:
            cellIdentifier = "TextCell2"
        case 4:
            cellIdentifier = "CollectionCell"
        
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
            
        case "CollectionCell":
            (cell as! TableViewCell).setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
            (cell as! TableViewCell).collectionViewOffset = storedOffsets[indexPath.row] ?? 0
            

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
        case 2:
            return 120
        case 3:
            return 200
        case 4:
            return 430
        default: ()
        return 200
        }
    }
    
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
}

extension ArticleTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cellIdentifier = ""
        switch indexPath.row {
        case 0:
            cellIdentifier = "MapCell"
        case 1:
            cellIdentifier = "WikiCell"
            
        default: ()
        }
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        switch cellIdentifier {
        case "MapCell":
            (cell as! MapCollectionViewCell).layer.borderColor = UIColor.FewsGreyBorderColor().CGColor
            (cell as! MapCollectionViewCell).layer.borderWidth = 1
            (cell as! MapCollectionViewCell).layer.cornerRadius = 5
            (cell as! MapCollectionViewCell).location = self.event.location
            
        case "WikiCell":
            (cell as! WikiCollectionViewCell).layer.borderColor = UIColor.FewsGreyBorderColor().CGColor
            (cell as! WikiCollectionViewCell).layer.borderWidth = 1
            (cell as! WikiCollectionViewCell).layer.cornerRadius = 5
            (cell as! WikiCollectionViewCell).titleLabel.text = event.wikipedias[0].name
            (cell as! WikiCollectionViewCell).textLabel.text = event.wikipedias[0].text

        default: ()
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath.row)")
    }
}
