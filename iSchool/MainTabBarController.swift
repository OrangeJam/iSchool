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
        let alert = UIAlertView(title: NSLocalizedString("Network Error", comment: "Title in network error message box"),
            message: NSLocalizedString("Myschool seems to be unreachable, try again later.", comment: "Message when there is a network error and MySchool can not be reached"),
            delegate: self,
            cancelButtonTitle: NSLocalizedString("Dismiss", comment: "Button to dismiss network error message box")
        )
        alert.show()
    }
}
