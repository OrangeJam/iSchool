//
//  TimetableTableViewController.swift
//  iSchool
//
//  Created by Björn Orri Sæmundsson on 11/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

class TimetableTableViewController: UITableViewController, UITableViewDataSource {

    var weekDay: WeekDay? = nil
    var dateFormatter: NSDateFormatter {
        let formatter = NSDateFormatter()
//        formatter.locale = NSLocale(localeIdentifier: "is_IS")
        formatter.dateFormat = "EEE d. MMM"
        
        return formatter
    }
    
    var emptyLabel: UILabel {
        let label = UILabel()
        label.text = NSLocalizedString("No Classes today.",  comment: "Label indicating the lack of classes for the current day")
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont(name: "System", size: 24)
        return label
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRectZero)
        self.refreshControl?.addTarget(self,
            action: "reloadData",
            forControlEvents: .ValueChanged
        )
        emptyLabel.frame = CGRect(x: 0, y: 150, width: self.view.frame.width, height: 50)
        self.tableView.addSubview(emptyLabel)
        
        // Add listeners to make sure the red line is always in the correct position.
        
        // Add listener for foreground entering.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableView", name: UIApplicationWillEnterForegroundNotification, object: nil)
        
        // Add listener for significant time changes (e.g. when a new day starts).
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableView", name: UIApplicationSignificantTimeChangeNotification, object: nil)
    }
    
    // Function that calls self.tableView.reloadData().
    // The only purpose is to use it as a selector.
    func reloadTableView() {
        println("Yo")
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        let pvc = self.parentViewController! as TimetablePageViewController
        let deltaDays = weekDay!.rawValue - pvc.currentWeekDay
        pvc.navigationItem.title = calculateDateTitle(deltaDays)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // This line is to prevent the red line animation from stopping.
        self.tableView.reloadData()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "refreshData",
            name: Notification.classes.rawValue,
            object: nil
        )
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "endRefresh",
            name: Notification.networkError.rawValue,
            object: nil
        )
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let day = weekDay {
            return DataStore.sharedInstance.getClassesForDay(day).count
        } else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ClassCell", forIndexPath: indexPath) as ClassCell
        if let day = weekDay {
            let dayClasses = DataStore.sharedInstance.getClassesForDay(day)
            let c = dayClasses[indexPath.row]
            cell.setClass(c)
            
            // Update the table view at the end of this class.
            if c.isNow() {
                let interval = c.endDate.timeIntervalSinceNow
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(interval * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
            // Update the table view at the beginning of the next class.
            else if !c.isOver() {
                if indexPath.row == 0 || dayClasses[indexPath.row - 1].isOver() {
                    let interval = c.startDate.timeIntervalSinceNow
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(interval * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                        self.tableView.reloadData()
                    })
                }
            }
        }
        return cell
    }
    
    func reloadData() {
        DataStore.sharedInstance.fetchClasses()
    }
    
    func endRefresh() {
        self.refreshControl?.endRefreshing()
    }
    
    func refreshData() {
        self.tableView.reloadData()
        endRefresh()
    }
    
    func calculateDateTitle(delta: Int) -> String {
        let deltaDay = NSDateComponents()
        deltaDay.setValue(delta, forComponent: NSCalendarUnit.DayCalendarUnit)
        
        let otherDay = NSCalendar.currentCalendar().dateByAddingComponents(deltaDay, toDate: NSDate(), options: NSCalendarOptions(0))!
        var date = dateFormatter.stringFromDate(otherDay)
        let firstLetter = date.substringToIndex(advance(date.startIndex,1)).uppercaseString
        date = firstLetter + date.substringFromIndex(advance(date.startIndex,1))
        
        return date
    }

}
