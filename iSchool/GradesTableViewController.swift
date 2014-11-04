//
//  GradesTableViewController.swift
//  iSchool
//
//  Created by Kári Helgason on 16/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

class GradesTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var gradsTitle: UINavigationItem!
    
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
        gradsTitle.title = NSLocalizedString("Grades", comment: "The title in the Grades view")
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return DataStore.sharedInstance.getGrades().count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let grades = DataStore.sharedInstance.getGrades()
        return grades[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let grades = DataStore.sharedInstance.getGrades()
        let cell = tableView.dequeueReusableCellWithIdentifier("GradesTableViewCell") as GradesTableViewCell
        cell.SetGrade(grades[indexPath.section][indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(40)
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        view.backgroundColor = UIColor(white: 1.0, alpha: 0.95)

        
        let label = UILabel(frame: CGRect(x: 20, y: 8, width: self.view.frame.size.width, height: 30))
        let title = DataStore.sharedInstance.getGrades()[section].first?.course
        label.text = title

        let redLine = UIView(frame: CGRect(x: 0, y: 39, width: self.view.frame.size.width, height: 1))
        redLine.backgroundColor = UIColor.redColor()
        
        view.addSubview(label)
        view.addSubview(redLine)

        return view;

    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func showNetworkErrorAlert() {
        let alert = UIAlertView(title: "Network Error", message: "Myschool has shit itself", delegate: self, cancelButtonTitle: "Fuck off")
        alert.show()
    }

}
