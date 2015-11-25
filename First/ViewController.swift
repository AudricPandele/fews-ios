//
//  ViewController.swift
//  First
//
//  Created by Audric Pandelé on 17/11/2015.
//  Copyright © 2015 Audric Pandelé. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController!
    var pageTitles: NSArray!
    var pageImages: NSArray!
    

    @IBAction func restartAction(sender: AnyObject) {
        let startVc = self.ViewControllerAtIndew(0) as ContentViewController
        let viewControllers = NSArray(object: startVc)
        
        self.pageViewController.view.frame =
            CGRectMake(0, 30, self.view.frame.width, self.view.frame.size.height - 60)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRect(x: 0, y: 30, width: self.view.frame.width, height: self.view.frame.size.height - 60)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.pageTitles = parseJSONTitles()
        self.pageImages = parseJSONImages()
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as? UIPageViewController
        self.pageViewController.dataSource = self
        
        let startVc = self.ViewControllerAtIndew(0) as ContentViewController
        let viewControllers = NSArray(object: startVc)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRect(x: 0, y: 30, width: self.view.frame.width, height: self.view.frame.size.height - 60)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ViewControllerAtIndew(Index: Int) -> ContentViewController{
        if ((self.pageTitles.count == 0 || Index >= self.pageTitles.count)){
            return ContentViewController()
        }
        
        let vc: ContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController
        vc.imageFile = self.pageImages[Index] as! String
        vc.titleText = self.pageTitles[Index] as! String
        vc.pageIndex = Index
        
        return vc
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        if (index == 0 || index == NSNotFound){
            return nil
        }
        
        index--
        return self.ViewControllerAtIndew(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound){
            return nil
        }
        
        index++

        if (index == self.pageTitles.count){
            return nil
        }
        
        return self.ViewControllerAtIndew(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func parseJSONTitles() -> NSMutableArray{
        let path: String = NSBundle.mainBundle().pathForResource("jsonFile", ofType: "json") as String!
        let jsonData = NSData(contentsOfFile: path) as NSData!
        let readableJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
        let nb = readableJSON.count
        let titles = NSMutableArray()
        
        for i in 0...nb-1 {
            titles.addObject(readableJSON[i]["articles"][0].string as String!)
        }
        
        return titles
    }
    
    func parseJSONImages() -> NSMutableArray{
        let path: String = NSBundle.mainBundle().pathForResource("jsonFile", ofType: "json") as String!
        let jsonData = NSData(contentsOfFile: path) as NSData!
        let readableJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
        let nb = readableJSON.count
        let titles = NSMutableArray()
        
        for i in 0...nb-1 {
            titles.addObject(readableJSON[i]["images"][0].string as String!)
        }
        
        return titles
    }


}

