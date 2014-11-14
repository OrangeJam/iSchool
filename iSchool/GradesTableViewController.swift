//
//  GradesTableViewController.swift
//  iSchool
//
//  Created by Kári Helgason on 16/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

class GradesTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var emptyLabel: UILabel!
    var data: ([[Grade]])?
    @IBOutlet weak var gradsTitle: UINavigationItem!
    
    override func viewDidLoad() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = UIColor.grayColor()
        self.refreshControl?.addTarget(self,
            action: "reloadData",
            forControlEvents: .ValueChanged
        )
        self.emptyLabel.frame = CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: self.emptyLabel.frame.height)
        // Set the text of the empty label.
        self.emptyLabel.text = NSLocalizedString("No grades", comment: "Text for the empty label when there are no grades")
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
        data = DataStore.sharedInstance.getGrades()
        gradsTitle.title = NSLocalizedString("Grades", comment: "The title in the Grades view")
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let data = self.data {
            self.emptyLabel.hidden = !(data.count == 0)
            return data.count
        } else {
            self.emptyLabel.hidden = false
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
        return CGFloat(30)
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 30))
        view.backgroundColor = UIColor(white: 1.0, alpha: 0.95)

        
        let label = UILabel(frame: CGRect(x: 20, y: 6, width: self.view.frame.size.width, height: 20))
        if let title = data?[section].first?.course {
            label.font = UIFont(name: "System", size: 10)
            label.text = title
        } else {
            return nil
        }
        let redLine = UIView(frame: CGRect(x: 0, y: 29, width: self.view.frame.size.width, height: 1))
        redLine.backgroundColor = UIColor(red: 204, green: 0, blue: 0, alpha: 1)
        
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let detail = self.storyboard?.instantiateViewControllerWithIdentifier("DetailView") as? DetailViewController {
            if let grade = data?[indexPath.section][indexPath.row] {
                detail.setDetailForURL(NSURL(string: grade.URL)!, title: grade.name)
                let bbItem = UIBarButtonItem(title: NSLocalizedString("Back", comment: "Back button to go back to grades table view"), style: .Plain, target: nil, action: nil)
                navigationItem.backBarButtonItem = bbItem
                navigationController?.pushViewController(detail, animated: true)
            }
        }
    }
}
