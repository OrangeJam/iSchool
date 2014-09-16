//
//  GradesTableViewController.swift
//  iSchool
//
//  Created by Kári Helgason on 16/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

class GradesTableViewCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
}

class GradesTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStore.sharedInstance.getAssignments().count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let grades = DataStore.sharedInstance.getGrades()
        let cell = tableView.dequeueReusableCellWithIdentifier("GradesTableViewCell") as GradesTableViewCell
        cell.nameLabel.text = grades[indexPath.row].name
        return cell
    }

}
