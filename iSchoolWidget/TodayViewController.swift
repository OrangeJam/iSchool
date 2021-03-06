//
//  TodayViewController.swift
//  iSchoolWidget
//
//  Created by Kári Helgason on 19/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit
import NotificationCenter
import QuartzCore

class TodayViewController: UITableViewController, NCWidgetProviding {
    
    var items: [Assignment]?
    
    var loggedIn = false
    
    var loginButton: UIButton {
        let b = UIButton()
        b.addTarget(self, action: "openApp", forControlEvents: .TouchUpInside)
        b.setTitle("Login", forState: .Normal)
        b.setTitleColor(UIColor.blackColor(), forState: .Normal)
        b.titleLabel?.font = UIFont.systemFontOfSize(14)
        b.layer.backgroundColor = UIColor(white: 1.0, alpha: 0.5).CGColor
        b.layer.cornerRadius = 3
        return b
    }
    
    var noAssignmentsLabel: UILabel {
        let l = UILabel()
        l.text = "No Assignments. Take a day off!"
        l.textColor = UIColor.lightGrayColor()
        return l
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.sectionHeaderHeight = 0
        tableView.rowHeight = 55
        loggedIn = getLoggedInStatus()
        println("Logged in: \(loggedIn)")
        items = DataStore.sharedInstance.getAssignments()
        if !loggedIn {
            items = nil
        }
        updateHeaderAndFooterHeight()
        updatePreferredContentSize()
        // Do any additional setup after loading the view from its nib.
    }
    
    func getLoggedInStatus() -> Bool {
        if let _ = CredentialManager.sharedInstance.getCredentials() {
            return true
        } else {
            println("Not logged in =(")
            return false
        }
    }
    
    func updatePreferredContentSize() {
        println("Header: \(tableView.sectionHeaderHeight), Footer: \(tableView.sectionFooterHeight)")
        preferredContentSize = CGSizeMake(CGFloat(0),
            CGFloat(tableView(tableView, numberOfRowsInSection: 0)) * tableView.rowHeight +
            tableView.sectionFooterHeight + tableView.sectionHeaderHeight
        )
    }
    
    func openApp() {
        println("HEHE ég ætla opna appið núna híhí")
        let appURL = NSURL(string: "iSchool://")
        self.extensionContext?.openURL(appURL!, completionHandler: nil)
    }
    
    func updateHeaderAndFooterHeight() {
        tableView.sectionFooterHeight = loggedIn ? 0 : 40
        if loggedIn {
            if let items = self.items {
                tableView.sectionHeaderHeight = items.count == 0 ? 40 : 0
            } else {
                tableView.sectionHeaderHeight = 40
            }
        }
        println("\(tableView.sectionHeaderHeight)")
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return noAssignmentsLabel
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.addSubview(loginButton)
        println(loginButton.frame)
        return loggedIn ? nil : footerView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        loadAssignments(completionHandler)
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
    
    func loadAssignments(completionHandler: ((NCUpdateResult) -> Void!)) {
        if let (user, pass) = CredentialManager.sharedInstance.getCredentials() {
            let nc = NetworkClient(username: user, password: pass)
            nc.fetchPage(.Assignments,
            successHandler: { (resp, data) in
                println("Nettöööööör")
                let newItems = Parser.parseAssignments(data as NSData)
                if self.hasNewData(newItems) {
                    println("new data")
                    self.items = newItems
                    self.updateHeaderAndFooterHeight()
                    self.updatePreferredContentSize()
                    self.tableView.reloadData()
                    completionHandler(.NewData)
                } else {
                    completionHandler(.NoData)
                }
                
            },
            errorHandler: { error in
                println("Nei Björn.")
                println(error)
                completionHandler(.Failed)
            })
        } else {
            completionHandler(.Failed)
        }
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        openApp()
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.selected = false
        }
    }
    
}
