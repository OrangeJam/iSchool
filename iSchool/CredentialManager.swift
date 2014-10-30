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
    
    private let userDefaults = NSUserDefaults(suiteName: "is.orangejam.ischool")

    class var sharedInstance: CredentialManager {
        return _credentialManager
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
    
    func getBase64EncodedAuthString() -> String? {
        if let (user, pass) = getCredentials() {
            let authstring = user + ":" + pass
            let data = authstring.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            return data?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(0))
        } else {
            return nil
        }
    }
}