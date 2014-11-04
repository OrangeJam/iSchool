//
//  GradesTableViewController.swift
//  iSchool
//
//  Created by Kári Helgason on 16/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

class GradesTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var data: ([[Grade]])?
    @IBOutlet weak var gradsTitle: UINavigationItem!
    
    override func viewDidLoad() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = UIColor.grayColor()
        self.refreshControl?.addTarget(self,
            action: "reloadData",
            forControlEvents: .ValueChanged
        )
        tableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "refreshData",
            name: Notification.grade.rawValue,
            object: nil
        )
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "endRefresh",
            name: Notification.networkError.rawValue,
            object: nil
        )
        DataStore.sharedInstance.fetchAssignments()
        gradsTitle.title = NSLocalizedString("Grades", comment: "The title in the Grades view")
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let data = self.data {
            return data.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let section = data?[section] {
            return section.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GradesTableViewCell") as GradesTableViewCell
        if let grade = data?[indexPath.section][indexPath.row] {
            cell.SetGrade(grade)
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(40)
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 30))
        view.backgroundColor = UIColor(white: 1.0, alpha: 0.95)

        
        let label = UILabel(frame: CGRect(x: 20, y: 8, width: self.view.frame.size.width, height: 20))
        if let title = data?[section].first?.course {
            label.font = UIFont(name: "System", size: 11)
            label.text = title
        } else {
            return nil
        }
        let redLine = UIView(frame: CGRect(x: 0, y: 29, width: self.view.frame.size.width, height: 1))
        redLine.backgroundColor = UIColor.redColor()
        
        view.addSubview(label)
        view.addSubview(redLine)

        return view;

    }
    
    func refreshData() {
        self.refreshControl?.endRefreshing()
        data = DataStore.sharedInstance.getGrades()
        self.tableView.reloadData()
    }
    
    func reloadData() {
        DataStore.sharedInstance.fetchAssignments()
    }
    
    func endRefresh() {
        refreshControl?.endRefreshing()
    }
}
