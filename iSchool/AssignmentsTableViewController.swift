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
        self.tableView.rowHeight = 44
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "refreshData",
            name: Notification.assignment.toRaw(),
            object: nil
        )
        DataStore.sharedInstance.fetchAssignments()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
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
        cell.nameLabel.text = assignments[indexPath.row].name
        return cell
    }
    
    func refreshData() {
        self.tableView.reloadData()
    }
}