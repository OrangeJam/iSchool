//
//  NetworkClientTests.swift
//  iSchool
//
//  Created by Kári Helgason on 03/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import iSchool
import UIKit
import XCTest

class NetworkClientTests: XCTestCase {
    
    var nc = NetworkClient()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchAssignmentPage() {
        let expectation = expectationWithDescription("Fetch assignments")
        
        nc.fetchAssignmentsPageWithSuccessHandler({ (operation, response) in
            expectation.fulfill()
            XCTAssertNotNil(response)
        })
        
        waitForExpectationsWithTimeout(nc.timeoutInterval, handler: { error in
            
        })
        
    }
    
}