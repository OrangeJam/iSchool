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

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testStoreCredentials() {
        // Clear user defaults
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.removeObjectForKey("username")
        userDefaults.removeObjectForKey("password")
        userDefaults.synchronize()
        
        XCTAssertNil(userDefaults.stringForKey("username"), "Stored username is not nil in beginning of test")
        XCTAssertNil(userDefaults.stringForKey("password"), "Stored password is not nil in beginning of test")
        _credentialManager.storeCredentials("user", "lamepassword")
        XCTAssertEqual("user", userDefaults.stringForKey("username")!, "Username not stored correctly")
        XCTAssertEqual("lamepassword", userDefaults.stringForKey("password")!, "Password not stored correctly")
        
        // Tear down for this test case
        // Clear user defaults
        userDefaults.removeObjectForKey("username")
        userDefaults.removeObjectForKey("password")
        super.tearDown()
        userDefaults.synchronize()
    }
    
    func testGetCredentials() {
        
    }
    
    func testClearCredentials() {
        clearCredentials()
        
    }
}
