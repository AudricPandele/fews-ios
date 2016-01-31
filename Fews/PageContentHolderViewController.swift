//
//  PageContentHolderViewController.swift
//  Fews
//
//  Created by Audric Pandelé on 09/12/2015.
//  Copyright © 2015 Audric Pandelé. All rights reserved.
//

import UIKit
import Haneke
import SwiftDate

class PageContentHolderViewController: UIViewController {

    @IBOutlet weak var imageSource: UIImageView!
    @IBOutlet weak var imageSource2: UIImageView!
    @IBOutlet weak var imageSource3: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nbOfSourceLeftLabel: UILabel!
    
    var pageIndex: Int!
    var event: Event!
        
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true);
        
        if let gest = self.view.gestureRecognizers{
            for gR: UIGestureRecognizer in gest {
                gR.delegate = (self as! UIGestureRecognizerDelegate)
            }
        }
        self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.alpha = 0.0
        self.titleLabel.text = self.event.prepareArticleShortenTitle()
        
        UIView.animateWithDuration(1.0, animations: {
            self.titleLabel.alpha = 1.0
        })
        
        if let url = NSURL(string: self.event.top_image.original) {
            imageView.hnk_setImageFromURL(url)
        }
        
        let sources: [UIImageView] = [self.imageSource, self.imageSource2, self.imageSource3]
        for (article, source) in zip(event.articles, sources) {
            if let url = NSURL(string: article.logo) {
                source.hnk_setImageFromURL(url)
            }
        }
        
        let nbOfSourcesPerEvent = 3
        let nbOfSources = self.event.NbArticles()
        let nbOfSourcesLeft = nbOfSources - nbOfSourcesPerEvent
        if (nbOfSourcesLeft > 0){
            self.nbOfSourceLeftLabel.text = "+\(nbOfSourcesLeft)"
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
            
            destinationVC.event = self.event
        }
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
    }
    
    @IBAction func goToArticle(sender: AnyObject) {
        performSegueWithIdentifier("ArticleViewController", sender: self)
    }

}
