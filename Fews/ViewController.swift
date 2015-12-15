//
//  ViewController.swift
//  Fews
//
//  Created by Audric Pandelé on 09/12/2015.
//  Copyright © 2015 Audric Pandelé. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageImages: NSArray! = []
    var pageTitles: NSArray! = []
    var pageViewController: UIPageViewController!
    var count = 0
    var JsonEntity: Entity = Entity(path: NSBundle.mainBundle().pathForResource("jsonFile", ofType: "json") as String!)
    let imagesArray: NSMutableArray! = []
    
    @IBOutlet weak var loading: UILabel!
    var overlay : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageTitles = parseJSONTitles()
        self.pageImages = parseJSONImages()
        
        for i in 0...self.JsonEntity.readableJSON.count-1 {
            if let url = NSURL(string: self.JsonEntity.readableJSON[i]["images"][0].string as String!),
                data = NSData(contentsOfURL: url){
                    imagesArray.addObject(UIImage(data: data)!)
                    NSLog("image loaded")
            }
        }
        
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
        let titles = NSMutableArray()
        for j in 0...self.JsonEntity.countImagesSources(index)-1{
            titles.addObject(self.JsonEntity.readableJSON[index]["sources"][j]["image"].string as String!)
        }

        let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentHolderViewController") as! PageContentHolderViewController
        
        pageContentViewController.textArticle = self.JsonEntity.readableJSON[index]["text"].string! as String
        pageContentViewController.imageFileName = self.imagesArray[index] as! UIImage
        pageContentViewController.titleText = pageTitles![index] as! String
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
            NSLog("not found")
            return nil
        }
        NSLog("page index before: \(index)")

        index++
        NSLog("page index after: \(index)")
        
        if (index == 0){
            print("Helllooooo")
        }

        if(index == pageImages!.count)
        {
            NSLog("Index: \(index). Images count: \(pageImages!.count)")
            NSLog("end")
            let old: Int = pageImages!.count
            NSLog("old: \(old)")
            NSLog("=== Before: \(JsonEntity.readableJSON.count). Count: \(pageImages!.count)")
            JsonEntity.addToJson(JsonEntity.jsonData)
            self.pageTitles = parseJSONTitles()
            self.pageImages = parseJSONImages()
            NSLog("=== After: \(JsonEntity.readableJSON.count). Count: \(pageImages!.count)")
            self.reload(old)
            return self.pageTutorialAtIndex(old)
        }
        return self.pageTutorialAtIndex(index)
    }

    
    func reload(start: Int = 0){
        for i in start...self.JsonEntity.readableJSON.count-1 {
            if let url = NSURL(string: self.JsonEntity.readableJSON[i]["images"][0].string as String!),
                data = NSData(contentsOfURL: url){
                self.imagesArray.addObject(UIImage(data: data)!)
                NSLog("image loaded")
            }
        }
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageImages!.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
    func parseJSONTitles() -> NSMutableArray{
        let nb = self.JsonEntity.readableJSON.count
        let titles = NSMutableArray()
        
        for i in 0...nb-1 {
            titles.addObject(self.JsonEntity.readableJSON[i]["articles"][0].string as String!)
        }
        
        return titles
    }
    
    func parseJSONImages() -> NSMutableArray{
        let nb = self.JsonEntity.readableJSON.count
        let titles = NSMutableArray()
        
        for i in 0...nb-1 {
            titles.addObject(self.JsonEntity.readableJSON[i]["images"][0].string as String!)
        }
        
        return titles
    }

}

