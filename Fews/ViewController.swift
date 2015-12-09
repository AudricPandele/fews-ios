//
//  ViewController.swift
//  Fews
//
//  Created by Audric Pandelé on 09/12/2015.
//  Copyright © 2015 Audric Pandelé. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageImages: NSArray!
    var pageTitles: NSArray!
    var pageViewController: UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageTitles = parseJSONTitles()
        self.pageImages = parseJSONImages()
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        let initialContenViewController = self.pageTutorialAtIndex(0) as PageContentHolderViewController
        
        let viewControllers = NSArray(object: initialContenViewController)
        
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+100)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func pageTutorialAtIndex(index: Int) -> PageContentHolderViewController
    {
        let path: String = NSBundle.mainBundle().pathForResource("jsonFile", ofType: "json") as String!
        let jsonData = NSData(contentsOfFile: path) as NSData!
        let readableJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
        let titles = NSMutableArray()
        let nbImages = readableJSON[index]["sources"].count
        
        for j in 0...nbImages-1{
            titles.addObject(readableJSON[index]["sources"][j]["image"].string as String!)
        }

        
        let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentHolderViewController") as! PageContentHolderViewController
        
        pageContentViewController.textArticle = readableJSON[index]["text"].string! as String
        pageContentViewController.imageFileName = pageImages[index] as! String
        pageContentViewController.titleText = pageTitles[index] as! String
        pageContentViewController.sourceImageName = titles as NSArray
        pageContentViewController.pageIndex = index
        
        return pageContentViewController
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! PageContentHolderViewController
        var index = viewController.pageIndex as Int
        
        if(index == 0 || index == NSNotFound)
        {
            return nil
        }
        
        index--
        
        return self.pageTutorialAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! PageContentHolderViewController
        var index = viewController.pageIndex as Int
        
        if((index == NSNotFound))
        {
            return nil
        }
        
        index++
        
        if(index == pageImages.count)
        {
            return nil
        }
        
        return self.pageTutorialAtIndex(index)
    }

    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageImages.count
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

