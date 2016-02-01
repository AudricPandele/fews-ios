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
    var jsonDay: String!
    var pageViewController: UIPageViewController!
    var eventsList: EventsList = EventsList()
    var overlay : UIView?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true);
        
        UIApplication.sharedApplication().statusBarHidden=true;
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
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
        
        let JsonEntity: JsonObject = JsonObject(path: NSBundle.mainBundle().pathForResource(jsonDay, ofType: "json") as String!)
        
        eventsList = JsonEntity.JsonToEventsList(eventsList)
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
            return nil
        }
        index++
        
        if(index == self.eventsList.lenght())
        {
            return nil
        }
        return self.pageTutorialAtIndex(index)
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}

