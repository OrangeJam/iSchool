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
    
    var tableData: [Assignment] = []
    
    override func viewDidLoad() {
        loadData()
        super.viewDidLoad()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AssignmentsTableViewCell") as AssignmentsTableViewCell
        if (tableData.count > indexPath.row) {
            let assignment = tableData[indexPath.row]
            cell.nameLabel.text = "Sveppir"
        }
        return cell
    }
    
    func loadData() {
        let credentialManager = CredentialManager.sharedInstance
        if let (username, password) = credentialManager.getCredentials() {
            let networkClient = NetworkClient(username: username, password: password)
            networkClient.fetchPage(Page.Assignments,
                successHandler: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                    let responseData = NSData(data: response as NSData)
                    self.tableData = Parser.parseAssignments(responseData)
                    self.tableView.reloadData()
                },
                errorHandler: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    NSLog("Error: \(error.description)")
                }
            )
        }
    }
}