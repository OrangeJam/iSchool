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
    
    var networkClient = NetworkClient(username: "test", password: "test")
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPostsNotificationOnFetchAssignments() {
        let expectation = expectationWithDescription("Should recieve notification")
        NSNotificationCenter.defaultCenter().addObserverForName(
            Notification.assignment.toRaw(),
            object: nil,
            queue: NSOperationQueue.mainQueue(),
            usingBlock: { _ in
                expectation.fulfill()
            }
        )
        waitForExpectationsWithTimeout(10, handler: { _ in
            
        })
    }
}