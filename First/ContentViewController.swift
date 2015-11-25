//
//  ContentViewController.swift
//  First
//
//  Created by Audric Pandelé on 25/11/2015.
//  Copyright © 2015 Audric Pandelé. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    
    var pageIndex: Int!
    var titleText: String!
    var imageFile: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.imageView.image = UIImage(named: self.imageFile)
        
        if let url = NSURL(string: self.imageFile) {
            if let data = NSData(contentsOfURL: url) {
                imageView.image = UIImage(data: data)
            }
        }
        
        
        
        self.titleLable.text = self.titleText
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
