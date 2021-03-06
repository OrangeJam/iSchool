//
//  CredentialManager.swift
//  iSchool
//
//  Created by Björn Orri Sæmundsson on 29/08/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

private let _credentialManager = CredentialManager()

class CredentialManager {
    
    private let userDefaults = NSUserDefaults(suiteName: "group.is.orangejam.iSchool")!

    class var sharedInstance: CredentialManager {
        return _credentialManager
    }
    
    func hasCredentials() -> Bool {
        if let _ = getCredentials() {
            return true
        } else {
            return false
        }
    }
    
    func storeCredentials(username: String!, _ password: String!) {
        userDefaults.setObject(username, forKey: "username")
        userDefaults.setObject(password, forKey: "password")
        userDefaults.synchronize()
    }
    
    func getCredentials() -> (String, String)? {
        let username = userDefaults.stringForKey("username")
        let password = userDefaults.stringForKey("password")
        if(username != nil || password != nil) {
            return (username!, password!)
        }
        return nil
    }
    
    func clearCredentials() {
        userDefaults.removeObjectForKey("username")
        userDefaults.removeObjectForKey("password")
        userDefaults.synchronize()
    }
}