//
//  AssignmentsTableViewController.swift
//  iSchool
//
//  Created by Kári Helgason on 05/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

class AssignmentsTableViewCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
}

class AssignmentsTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserverForName(
            Notification.assignment.toRaw(),
            object: nil,
            queue: NSOperationQueue.mainQueue(),
            usingBlock: { _ in
                self.tableView.reloadData()
            }
        )
        
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
        cell.nameLabel.text = assignments[indexPath.row].name
        return cell
    }
    
    // Hopefully this will not be required, might be an XCode 6 bug
    override func tableView(tableView:UITableView, heightForRowAtIndexPath indexPath:NSIndexPath)-> CGFloat {
        return 44
    }
    
    func refreshData() {
        self.tableView.reloadData()
    }
}