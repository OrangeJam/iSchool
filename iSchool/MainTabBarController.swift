//
//  MainTabBarController.swift
//  iSchool
//
//  Created by Kári Helgason on 17/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

class MainTabBarController : UITabBarController {
    
    // Ensure first alert is always shown
    var lastAlertTime = NSDate(timeIntervalSince1970: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserverForName(
            Notification.networkError.rawValue,
            object: nil,
            queue: NSOperationQueue.mainQueue(),
            usingBlock: { _ in
                if NSDate().timeIntervalSinceDate(self.lastAlertTime) > NSTimeInterval(5) {
                    self.showNetworkErrorAlert()
                }
                if !CredentialManager.sharedInstance.hasCredentials() {
                    self.presentLoginView()
                }
            }
        )
        self.reset()
    }
    
    func reset() {
        // Reload all the data.
        reloadAllTableViews()
        // Set the leftmost tab as the selected tab.
        self.selectedIndex = 0
    }
    
    func reloadAllTableViews() {
        // Reload data in all table views.
        for vc in self.viewControllers as [UIViewController] {
            if vc.isKindOfClass(UINavigationController.self) {
                for childVC in vc.childViewControllers as [UIViewController] {
                    if childVC.isKindOfClass(UITableViewController.self) {
                        let tableVC = childVC as UITableViewController
                        tableVC.tableView.reloadData()
                        println("Reloaded table view from tab VC")
                    }
                }
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if let credentials = CredentialManager.sharedInstance.getCredentials() {
            DataStore.sharedInstance.fetchClasses()
            DataStore.sharedInstance.fetchAssignments()
        } else {
            presentLoginView()
        }
    }
    
    func presentLoginView() {
        performSegueWithIdentifier("presentLoginView", sender: self)
    }
    
    func showNetworkErrorAlert() {
        let alert = UIAlertView(title: NSLocalizedString("Network Error", comment: "Title in network error message box"),
            message: NSLocalizedString("Myschool seems to be unreachable, try again later.", comment: "Message when there is a network error and MySchool can not be reached"),
            delegate: self,
            cancelButtonTitle: NSLocalizedString("Dismiss", comment: "Button to dismiss network error message box")
        )
        lastAlertTime = NSDate()
        alert.show()
    }
}
