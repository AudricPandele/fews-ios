//
//  TableViewController.swift
//  Fews
//
//  Created by Audric Pandelé on 30/01/2016.
//  Copyright © 2016 Audric Pandelé. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    let JsonEntity: JsonObject = JsonObject(path: NSBundle.mainBundle().pathForResource("home", ofType: "json") as String!)
    
    @IBAction func openMenu(sender: AnyObject) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer?.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true);
        
        UIApplication.sharedApplication().statusBarHidden=false;

        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.FewsBlueColor()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let homePics = JsonEntity.readableJSON.arrayObject
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DaysCell", forIndexPath: indexPath)
        
        if let url = NSURL(string: homePics![indexPath.row]["top_image"]!!["original"] as! String!),
            data = NSData(contentsOfURL: url){
            (cell as! DaysTableViewCell).imgView.image = UIImage(data: data)!
        }
        
        switch indexPath.row {
        case 0:
            (cell as! DaysTableViewCell).daysLabel.text = "January 31"
        case 1:
            (cell as! DaysTableViewCell).daysLabel.text = "January 30"
        case 2:
            (cell as! DaysTableViewCell).daysLabel.text = "January 29"
        case 3:
            (cell as! DaysTableViewCell).daysLabel.text = "January 28"
            
        default:()
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        let month = components.month
        let day = components.day

        if let navVC = segue.destinationViewController as? ViewController{
            if let indexPath = self.tableView.indexPathForSelectedRow {
                navVC.jsonDay = "\(month)\(day-indexPath.row)"
            }
        }
    }
    

}
