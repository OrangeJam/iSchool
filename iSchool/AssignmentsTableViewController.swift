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
        super.viewDidLoad()
        loadData()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: "loadData", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AssignmentsTableViewCell") as AssignmentsTableViewCell
        cell.nameLabel.text = tableData[indexPath.row].name
        return cell
    }
    
    // Hopefully this will not be required, might be an XCode 6 bug
    override func tableView(tableView:UITableView, heightForRowAtIndexPath indexPath:NSIndexPath)-> CGFloat {
        return 44
    }
    
    func loadData() {
        let credentialManager = CredentialManager.sharedInstance
        if let (username, password) = credentialManager.getCredentials() {
            let networkClient = NetworkClient(username: username, password: password)
            networkClient.fetchPage(Page.Assignments,
                successHandler: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                    let responseData = NSData(data: response as NSData)
                    self.tableData = Parser.parseAssignments(responseData)
                    dispatch_async(dispatch_get_main_queue(), {self.tableView.reloadData()})
                    self.refreshControl?.endRefreshing()
                },
                errorHandler: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    NSLog("Error: \(error.description)")
                }
            )
        }
    }
}