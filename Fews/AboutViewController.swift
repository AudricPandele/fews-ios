//
//  AboutViewController.swift
//  Fews
//
//  Created by Audric Pandelé on 31/01/2016.
//  Copyright © 2016 Audric Pandelé. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    @IBAction func twitter(sender: AnyObject) {
        if let link = NSURL(string: "http://\((button.titleLabel?.text)!)") {
            UIApplication.sharedApplication().openURL(link)
        }
    }
    @IBAction func goToURL(sender: AnyObject) {
        if let link = NSURL(string: "https://twitter.com/fewsio") {
            UIApplication.sharedApplication().openURL(link)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
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
