//
//  DataStoreTest.swift
//  iSchool
//
//  Created by Kári Helgason on 08/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit
import XCTest

class DataStoreTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPostsNotificationOnFetchAssignments() {
        let expectation = expectationWithDescription("Should recieve notification")
        CredentialManager.sharedInstance.storeCredentials("test", "test")
        NSNotificationCenter.defaultCenter().addObserverForName(
            Notification.networkError.toRaw(),
            object: nil,
            queue: NSOperationQueue.mainQueue(),
            usingBlock: { _ in
                expectation.fulfill()
            }
        )
        DataStore.sharedInstance.fetchAssignments()
        waitForExpectationsWithTimeout(10, handler: { _ in
            
        })
    }
}