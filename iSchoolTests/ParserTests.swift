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
        let data = NSString.stringWithContentsOfFile(testDataPath, encoding: 0, error: nil) as String
        NSLog(data)
        
    }
}
