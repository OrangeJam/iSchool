//
//  MainTabBarController.swift
//  iSchool
//
//  Created by Kári Helgason on 17/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

class MainTabBarController : UITabBarController {
    
    override func viewDidAppear(animated: Bool) {
        if let credentials = CredentialManager.sharedInstance.getCredentials() {
            DataStore.sharedInstance.fetchAssignments()
        } else {
            performSegueWithIdentifier("presentLoginView", sender: self)
        }
    }
    
    
}