//
//  PageContentHolderViewController.swift
//  Fews
//
//  Created by Audric Pandelé on 09/12/2015.
//  Copyright © 2015 Audric Pandelé. All rights reserved.
//

import UIKit

class PageContentHolderViewController: UIViewController {

    @IBOutlet weak var imageSource: UIImageView!
    @IBOutlet weak var imageSource2: UIImageView!
    @IBOutlet weak var imageSource3: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nbOfSourceLeftLabel: UILabel!
    
    var imageFileName: UIImage!
    var sourceImageName: NSArray!
    var titleText: String!
    var pageIndex: Int!
    var textArticle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = self.imageFileName
        self.titleLabel.alpha = 0.0
        self.titleLabel.text = self.titleText
        let nbOfSources = self.sourceImageName.count
        let nbOfSourcesLeft = nbOfSources - 3

        UIView.animateWithDuration(1.0, animations: {
            self.titleLabel.alpha = 1.0
        })

        if (nbOfSources >= 1){
            NSOperationQueue().addOperationWithBlock {
            if let url  = NSURL(string: self.sourceImageName[0] as! String),
                data = NSData(contentsOfURL: url)
            {
                NSOperationQueue.mainQueue().addOperationWithBlock {
                self.imageSource.image = UIImage(data: data)
                }
            }
            }
        }
        
        if (nbOfSources >= 2){
            NSOperationQueue().addOperationWithBlock {
            if let url  = NSURL(string: self.sourceImageName[1] as! String),
                data = NSData(contentsOfURL: url)
            {
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    self.imageSource2.image = UIImage(data: data)
                }
            }
            }
        }
        
        if (nbOfSources >= 3){
            NSOperationQueue().addOperationWithBlock {
            if let url  = NSURL(string: self.sourceImageName[2] as! String),
                data = NSData(contentsOfURL: url)
            {
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    self.imageSource3.image = UIImage(data: data)
                }
            }
        }
    }  
        
        if (nbOfSourcesLeft > 0){
            self.nbOfSourceLeftLabel.text = "+ \(nbOfSourcesLeft)"
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if let navVC = segue.destinationViewController as? UINavigationController,
        let destinationVC = navVC.topViewController as? ArticleTableViewController {
            
            navVC.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            navVC.navigationBar.shadowImage = UIImage()
            navVC.navigationBar.translucent = true
            
            destinationVC.titleArticle = self.titleText
            destinationVC.imageArticle = self.imageFileName
            destinationVC.textArticle = self.textArticle
        }
        
    }
    
    
    @IBAction func goToArticle(sender: AnyObject) {
        performSegueWithIdentifier("ArticleViewController", sender: self)
    }

}
