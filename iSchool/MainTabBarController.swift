//
//  MainTabBarController.swift
//  iSchool
//
//  Created by Kári Helgason on 17/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

class MainTabBarController : UITabBarController {
    
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserverForName(
            Notification.networkError.toRaw(),
            object: nil,
            queue: NSOperationQueue.mainQueue(),
            usingBlock: { _ in
                self.presentLoginView()
            }
        )
        if let credentials = CredentialManager.sharedInstance.getCredentials() {
            DataStore.sharedInstance.fetchAssignments()
        } else {
            presentLoginView()
        }
    }
    
    func presentLoginView() {
        performSegueWithIdentifier("presentLoginView", sender: self)
    }
}