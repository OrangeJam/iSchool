//
//  TimetablePageViewController.swift
//  iSchool
//
//  Created by Björn Orri Sæmundsson on 11/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

class TimetablePageViewController: UIPageViewController, UIPageViewControllerDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // This prevents the table view from going under the navigation bar.
        if self.respondsToSelector("edgesForExtendedLayout") {
            self.edgesForExtendedLayout = UIRectEdge.None
        }
        self.dataSource = self
        let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        let components = calendar.components(.WeekdayCalendarUnit, fromDate: NSDate())
        let today = components.weekday
        let initialViewController = viewControllerForWeekDay(WeekDay(rawValue: today)!)
        let viewControllers = [initialViewController]
        self.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)
        
        // Page control.
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        pageControl.backgroundColor = UIColor.clearColor()
    }
    
    func viewControllerForWeekDay(weekDay: WeekDay) -> TimetableTableViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
       let viewController = storyboard.instantiateViewControllerWithIdentifier("TimetableTableViewController") as TimetableTableViewController
        viewController.weekDay = weekDay
        return viewController
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let weekDay = (viewController as TimetableTableViewController).weekDay!
        if weekDay == WeekDay.Sunday {
            return nil;
        }
        return viewControllerForWeekDay(WeekDay(rawValue: weekDay.rawValue - 1)!)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let weekDay = (viewController as TimetableTableViewController).weekDay!
        if weekDay == WeekDay.Saturday {
            return nil;
        }
        return viewControllerForWeekDay(WeekDay(rawValue: weekDay.rawValue + 1)!)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 7
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
