//
//  NetworkClientTests.swift
//  iSchool
//
//  Created by Kári Helgason on 03/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit
import XCTest

class NetworkClientTests: XCTestCase {
    
    var networkClient = NetworkClient(username: "test", password: "test")
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchAssignmentPage() {
        let expectation = expectationWithDescription("Fetch assignments")
        
        networkClient.fetchPage(Page.Assignments, { (operation, response) in
            expectation.fulfill()
            XCTAssertNotNil(response)
        }, { (operation, error) in
            XCTAssert(operation.response.statusCode == 401)
            expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(networkClient.timeoutInterval, handler: { error in
            
        })
        
    }
    
    func testFetchDetailsForAssignment() {
        let assignment = Assignment(attrs: ["test", "test", "test",
            "?page=Exe&ID=2.4&ViewMode=2&View=52&verkID=49265&fagid=26706", "test", "test"])
        let expectation = expectationWithDescription(
            "It should fetch the detailview for the given assignment"
        )
        networkClient.fetchDetailsForAssignment(assignment, { (operation, response) in
            expectation.fulfill()
            XCTAssertNotNil(response)
            }, { (operation, error) in
                XCTAssert(operation.response.statusCode == 401)
                expectation.fulfill()
        })
        
    }
    
}
