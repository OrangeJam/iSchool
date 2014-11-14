//
//  AssignmentsTableViewController.swift
//  iSchool
//
//  Created by Kári Helgason on 05/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

class AssignmentsTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 50
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = UIColor.grayColor()
        self.refreshControl?.addTarget(self,
            action: "reloadData",
            forControlEvents: .ValueChanged
        )
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = LocalizationSystem.sharedInstance.localizedStringForKey("Assignments", comment: "Header title for the assignments tab.")
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "refreshData",
            name: Notification.assignment.rawValue,
            object: nil
        )
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "endRefresh",
            name: Notification.networkError.rawValue,
            object: nil
        )
        DataStore.sharedInstance.fetchAssignments()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStore.sharedInstance.getAssignments().count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let assignments = DataStore.sharedInstance.getAssignments()
        let cell = tableView.dequeueReusableCellWithIdentifier("AssignmentsTableViewCell") as AssignmentsTableViewCell
        cell.setAssignment(assignments[indexPath.row])
        return cell
    }
    
//    // Test when no assignments are due for user.
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 4
//    }
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let assignments = DataStore.sharedInstance.getAssignments()
//        let cell = tableView.dequeueReusableCellWithIdentifier("AssignmentsTableViewCell") as AssignmentsTableViewCell
//        cell.assignmentStub()
//        return cell
//    }
//    // Test ends
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let detail = self.storyboard?.instantiateViewControllerWithIdentifier("DetailView") as? DetailViewController {
            let assignments = DataStore.sharedInstance.getAssignments()
            let a = assignments[indexPath.row]
            detail.setDetailForURL(NSURL(string: a.URL)!, title: a.name)
            let bbItem = UIBarButtonItem(title: NSLocalizedString("Back", comment: "Back button"),
                style: .Plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = bbItem
            navigationController?.pushViewController(detail, animated: true)
        }
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.setSelected(false, animated: true)
    }
    
    func reloadData() {
        DataStore.sharedInstance.fetchAssignments()
        endRefresh()
    }
    
    func refreshData() {
        self.tableView.reloadData()
    }
    
    func endRefresh() {
        refreshControl?.endRefreshing()
    }
}
