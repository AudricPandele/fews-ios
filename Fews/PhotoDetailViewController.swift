//
//  PhotoDetailViewController.swift
//  Fews
//
//  Created by Pierre Brethes on 01/02/2016.
//  Copyright © 2016 Pierre Brethes. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarHidden=false;
        
        let logo = UIImage(named: "header_fews.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
