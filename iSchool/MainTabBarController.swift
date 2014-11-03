//
//  MainTabBarController.swift
//  iSchool
//
//  Created by Kári Helgason on 17/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

class MainTabBarController : UITabBarController {
    
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
                self.showNetworkErrorAlert()
                if !CredentialManager.sharedInstance.hasCredentials() {
                    self.presentLoginView()
                }
            }
        )
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
        let alert = UIAlertView(title: "Network Error",
            message: "Myschool seems to be unreachable, try again later.",
            delegate: self,
            cancelButtonTitle: "Dismiss"
        )
        alert.show()
    }
}
