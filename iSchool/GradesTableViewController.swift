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
    @IBOutlet weak var gradeLabel: UILabel!
}

class GradesTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "reloadData",
            name: Notification.classes.rawValue,
            object: nil
        )
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "showNetworkErrorAlert",
            name: Notification.networkError.rawValue,
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
        return DataStore.sharedInstance.getGrades().count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let grades = DataStore.sharedInstance.getGrades()
        let cell = tableView.dequeueReusableCellWithIdentifier("GradesTableViewCell") as GradesTableViewCell
        cell.nameLabel.text = grades[indexPath.row].name
        cell.gradeLabel.text = grades[indexPath.row].grade.description
        return cell
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func showNetworkErrorAlert() {
        let alert = UIAlertView(title: "Network Error", message: "Myschool has shit itself", delegate: self, cancelButtonTitle: "Fuck off")
        alert.show()
    }

}
