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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRectZero)
        self.refreshControl?.addTarget(self,
            action: "reloadData",
            forControlEvents: .ValueChanged
        )
    }
    
    override func viewDidAppear(animated: Bool) {
        let pvc = self.parentViewController! as TimetablePageViewController
        let deltaDays = weekDay!.rawValue - pvc.currentWeekDay
        pvc.navigationItem.title = calculateDateTitle(deltaDays)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "refreshData",
            name: Notification.classes.rawValue,
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
        }
        return cell
    }
    
    func reloadData() {
        DataStore.sharedInstance.fetchClasses()
    }
    
    func refreshData() {
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
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
