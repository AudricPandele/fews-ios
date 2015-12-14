//
//  ArticleViewController.swift
//  Fews
//
//  Created by Audric Pandelé on 09/12/2015.
//  Copyright © 2015 Audric Pandelé. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    
    @IBOutlet weak var titleArticleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var articleTextLabel: UILabel!
    
    var imageArticle: UIImage!
    var titleArticle: String!
    var textArticle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = imageArticle
        articleTextLabel.text = textArticle
        titleArticleLabel.text = titleArticle
        
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+100)
        
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

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}