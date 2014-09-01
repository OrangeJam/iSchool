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
    class var sharedInstance: CredentialManager {
        return _credentialManager
    }
    
    func storeCredentials(username: String!, _ password: String!) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(username, forKey: "username")
        userDefaults.setObject(password, forKey: "password")
        userDefaults.synchronize()
    }
    
    func getCredentials() -> (String?, String?) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let username = userDefaults.stringForKey("username")
        let password = userDefaults.stringForKey("password")
        return (username, password)
    }
    
    func clearCredentials() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.removeObjectForKey("username")
        userDefaults.removeObjectForKey("password")
        userDefaults.synchronize()
    }
}