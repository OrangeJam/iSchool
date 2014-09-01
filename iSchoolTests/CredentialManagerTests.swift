//
//  CredentialManagerTests.swift
//  iSchool
//
//  Created by Björn Orri Sæmundsson on 29/08/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit
import XCTest

class CredentialManagerTests: XCTestCase {

    let userDefaults = NSUserDefaults.standardUserDefaults()
    let user = "user"
    let pass = "lamepassword"
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testStoreCredentials() {
        clearStoredCredentials()
        CredentialManager.sharedInstance.storeCredentials(user, pass)
        XCTAssertNotNil(userDefaults.stringForKey("username"), "Stored username is nil")
        XCTAssertNotNil(userDefaults.stringForKey("password"), "Stored password is nil")
        if(userDefaults.stringForKey("username") != nil) {
            XCTAssertEqual(user, userDefaults.stringForKey("username")!, "Username not stored correctly")
        }
        
        if(userDefaults.stringForKey("password") != nil) {
            XCTAssertEqual(pass, userDefaults.stringForKey("password")!, "Password not stored correctly")
        }
        clearStoredCredentials()
    }
    
    func testGetCredentials() {
        clearStoredCredentials()
        CredentialManager.sharedInstance.storeCredentials(user, pass)
        let (username, password) = CredentialManager.sharedInstance.getCredentials()
        XCTAssertNotNil(username, "Retreived username is nil")
        XCTAssertNotNil(password, "Retreived password is nil")
        if(username != nil) {
            XCTAssertEqual(user, username!, "Username not retreived correctly")
        }
        
        if(password != nil) {
            XCTAssertEqual(user, password!, "Password not retreived correctly")
        }
        clearStoredCredentials()
    }
    
    func testClearCredentials() {
        userDefaults.setObject(user, forKey: "username")
        userDefaults.setObject(pass, forKey: "password")
        userDefaults.synchronize()
        CredentialManager.sharedInstance.clearCredentials()
        XCTAssertNil(userDefaults.stringForKey("username"), "Username is not nil after clearing")
        XCTAssertNil(userDefaults.stringForKey("password"), "Password is not nil after clearing")
        clearStoredCredentials()
    }
    
    private func clearStoredCredentials() {
        userDefaults.removeObjectForKey("username")
        userDefaults.removeObjectForKey("password")
        userDefaults.synchronize()
    }
}
