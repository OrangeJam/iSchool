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
        XCTAssertEqual(user, userDefaults.stringForKey("username")!, "Username not stored correctly")
        XCTAssertEqual(pass, userDefaults.stringForKey("password")!, "Password not stored correctly")
        clearStoredCredentials()
    }
    
    func testGetCredentials() {
        
    }
    
    func testClearCredentials() {
        
    }
    
    private func clearStoredCredentials() {
        userDefaults.removeObjectForKey("username")
        userDefaults.removeObjectForKey("password")
        userDefaults.synchronize()
    }
}
