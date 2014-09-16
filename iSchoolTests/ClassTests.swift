//
//  ClassTests.swift
//  iSchool
//
//  Created by Björn Orri Sæmundsson on 04/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import XCTest

class ClassTests: XCTestCase {
    
    // Class from the past
    let pastClass = Class(course: "Course1", type: ClassType.Lecture, location: "M101", startDate: NSDate().dateByAddingTimeInterval(-2 * 60 * 60), endDate: NSDate().dateByAddingTimeInterval(-1 * 60 * 60))
    
    // Class that is going on right now
    let currentClass = Class(course: "Course2", type: ClassType.Lecture, location: "V201", startDate: NSDate().dateByAddingTimeInterval(-1 * 60 * 30), endDate: NSDate().dateByAddingTimeInterval(1 * 60 * 30))
    
    // Future class
    let futureClass = Class(course: "Course3", type: ClassType.Discussion, location: "M108", startDate: NSDate().dateByAddingTimeInterval(1 * 60 * 60), endDate: NSDate().dateByAddingTimeInterval(2 * 60 * 60))
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIsOver() {
        XCTAssertTrue(pastClass.isOver(), "isOver() incorrect for pastClass")
        XCTAssertFalse(currentClass.isOver(), "isOver() incorrect for currentClass")
        XCTAssertFalse(futureClass.isOver(), "isOver() incorrect for futureClass")
    }
    
    func testIsNow() {
        XCTAssertFalse(pastClass.isNow(), "isNow() incorrect for pastClass")
        XCTAssertTrue(currentClass.isNow(), "isNow() incorrect for currentClass")
        XCTAssertFalse(futureClass.isNow(), "isNow() incorrect for futureClass")
    }
}
