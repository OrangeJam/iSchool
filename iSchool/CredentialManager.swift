//
//  CredentialManager.swift
//  iSchool
//
//  Created by Björn Orri Sæmundsson on 29/08/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

private let _credentialManager = CredentialManager()

class CredentialManager {
    class var sharedInstance: CredentialManager {
        return _credentialManager
    }
    
    func storeCredentials(username: String!, _ password: String!) {
        
    }
    
    func getCredentials() -> (String?, String?) {
        return (nil, nil)
    }
    
    func clearCredentials() {
        
    }
}