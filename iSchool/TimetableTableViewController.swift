//
//  TimetableTableViewController.swift
//  iSchool
//
//  Created by Björn Orri Sæmundsson on 11/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

class TimetableTableViewController: UITableViewController {

    var weekDay: WeekDay? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
