//
//  ViewController.swift
//  Fews
//
//  Created by Audric Pandelé on 09/12/2015.
//  Copyright © 2015 Audric Pandelé. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftDate

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate {
    
//    var pageTopImages: NSArray! = []
//    var pageTitles: NSArray! = []
//    let imagesArray: NSMutableArray! = []

    var pageViewController: UIPageViewController!
    var JsonEntity: JsonObject = JsonObject(path: NSBundle.mainBundle().pathForResource("events", ofType: "json") as String!)
    var eventsList: EventsList = EventsList()
    
    @IBOutlet weak var loading: UILabel!
    var overlay : UIView?
    
    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarHidden=true;
        pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        
        for view in self.pageViewController.view.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.delegate = self
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController

        for view in self.pageViewController.view.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.delegate = self
            }
        }
        
        eventsList = self.JsonEntity.JsonToEventsList(eventsList)
        eventsList.shuffle()

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
        let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentHolderViewController") as! PageContentHolderViewController

        pageContentViewController.event = eventsList.find(index) 
        pageContentViewController.pageIndex = index
        
        return pageContentViewController
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! PageContentHolderViewController
        var index = viewController.pageIndex as Int
        
        if(index == 0 || index == NSNotFound){
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
        index++
        
        if (index == 0){
            print("Helllooooo")
        }
        
        if(index == self.eventsList.lenght())
        {
//            NSLog("Index: \(index). Images count: \(pageImages!.count)")
//            NSLog("end")
//            let old: Int = pageImages!.count
//            NSLog("old: \(old)")
//            NSLog("=== Before: \(JsonEntity.readableJSON.count). Count: \(pageImages!.count)")
//            JsonEntity.addToJson(JsonEntity.jsonData)
//            self.pageTitles = parseJSONTitles()
//            self.pageImages = parseJSONImages()
//            NSLog("=== After: \(JsonEntity.readableJSON.count). Count: \(pageImages!.count)")
//            self.reload(old)
//            return self.pageTutorialAtIndex(old)
            return nil
        }
        return self.pageTutorialAtIndex(index)
    }

    
//    func reload(start: Int = 0){
//        for i in start...self.JsonEntity.readableJSON.count-1 {
//            if let url = NSURL(string: self.JsonEntity.readableJSON[i]["images"][0].string as String!),
//                data = NSData(contentsOfURL: url){
//                self.imagesArray.addObject(UIImage(data: data)!)
//                NSLog("image loaded")
//            }
//        }
//    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return pageImages!.count
        return 3
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("ok")
        print(scrollView.contentOffset.y)
    }

}

