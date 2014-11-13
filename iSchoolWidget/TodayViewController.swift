//
//  TodayViewController.swift
//  iSchoolWidget
//
//  Created by Kári Helgason on 19/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UITableViewController, NCWidgetProviding {
    
    var items: [Assignment]?
    
    var loggedIn : Bool = {
            if let _ = CredentialManager.sharedInstance.getCredentials() {
                return true
            } else {
                println("Not logged in =(")
                return false
            }
        }()
    
    let loginButton = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 55
        loginButton.addTarget(self, action: "openApp", forControlEvents: .TouchUpInside)
        loginButton.setTitle("Login", forState: .Normal)
        loginButton.titleLabel?.font = UIFont.systemFontOfSize(20)
        items = DataStore.sharedInstance.assignments
        updateFooterHeight()
        updatePreferredContentSize()
        // Do any additional setup after loading the view from its nib.
    }
    
    func updatePreferredContentSize() {
        preferredContentSize = CGSizeMake(CGFloat(0),
            CGFloat(tableView(tableView, numberOfRowsInSection: 0)) * tableView.rowHeight +
            tableView.sectionFooterHeight
        )
    }
    
    func openApp() {
        println("HEHE ég ætla opna appið núna híhí")
        let appURL = NSURL(string: "iSchool://")
        self.extensionContext?.openURL(appURL!, completionHandler: nil)
    }
    
    func updateFooterHeight() {
        tableView.sectionFooterHeight = loggedIn ? 0 : 40
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return loggedIn ? nil : loginButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        loadAssignments(completionHandler)
    }
    
    func loadAssignments(completionHandler: (NCUpdateResult -> Void)!) {
        println("Loading")
        let assignments = DataStore.sharedInstance.getAssignments()
        if hasNewData(assignments) {
            println("New data")
            self.items = assignments
            self.tableView.reloadData()
            self.updatePreferredContentSize()
            completionHandler(.NewData)
        } else {
            completionHandler(.NoData)
        }
    }
    
    func hasNewData(data: [Assignment]) -> Bool {
        if let items = self.items {
            if items.count == data.count {
                for idx in 0..<items.count {
                    if items[idx] != data[idx] {
                        return true
                    }
                }
                return false
            }
        }
        return true
    }
    
    // MARK: TableView data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println(items?.count)
        return (items != nil) ? items!.count : 0
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AssignmentsTableViewCell")! as AssignmentsTableViewCell
        println("Getting cell for index \(indexPath.row)")
        if let data = items {
            cell.setAssignment(data[indexPath.row])
        }
        return cell
    }
    
}
