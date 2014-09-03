//
//  ParserTests.swift
//  iSchool
//
//  Created by Kári Helgason on 03/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import iSchool
import UIKit
import XCTest

class ParserTests: XCTestCase {
    
    let testDataPath = NSBundle(forClass: ParserTests.self).pathForResource("assignmentsPage", ofType: "html")!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testParseAssignments(){
        let data = NSData(contentsOfFile: testDataPath)
        let dueAssignments = Parser.parseAssignments(data)
        XCTAssertEqual(dueAssignments.count, 2, "There should be two assignments")
        XCTAssertEqual(dueAssignments[0].name, "hw1", "The name of the first should be hw1")
        
    }
}
