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
    
    var imageArticle: String!
    var titleArticle: String!
    var textArticle: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url  = NSURL(string: self.imageArticle),
            data = NSData(contentsOfURL: url)
        {
            imageView.image = UIImage(data: data)
        }
        
        articleTextLabel.text = textArticle
        titleArticleLabel.text = titleArticle
        
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+100)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
