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
        NSNotificationCenter.defaultCenter().addObserverForName(
            Notification.networkError.toRaw(),
            object: nil,
            queue: NSOperationQueue.mainQueue(),
            usingBlock: { _ in
                self.performSegueWithIdentifier("presentLoginView", sender: self)
            }
        )
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        if let credentials = CredentialManager.sharedInstance.getCredentials() {
            println("Creds: \(credentials)")
            DataStore.sharedInstance.fetchAssignments()
        } else {
            performSegueWithIdentifier("presentLoginView", sender: self)
        }
    }
}