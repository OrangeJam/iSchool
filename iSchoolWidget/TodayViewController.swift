//
//  TodayViewController.swift
//  iSchoolWidget
//
//  Created by Kári Helgason on 19/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit
import NotificationCenter


class TodayTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
}

class TodayViewController: UITableViewController, NCWidgetProviding {
    
    var items: [Assignment]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 40
        updatePreferredContentSize()
        // Do any additional setup after loading the view from its nib.
    }
    
    func updatePreferredContentSize() {
        preferredContentSize = CGSizeMake(CGFloat(0),
            CGFloat(tableView(tableView, numberOfRowsInSection: 0)) * tableView.rowHeight
        )
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
        let items = DataStore.sharedInstance.getAssignments()
        completionHandler(.NewData)
    }
    
    // MARK: TableView data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TodayTableViewCell")! as TodayTableViewCell
        if let data = items {
            cell.nameLabel.text = data[indexPath.row].name
        }
        
        return cell
    }
    
}
