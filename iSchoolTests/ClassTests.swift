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
    let pastClass = Class(course: "Course1", type: ClassType.Lecture, location: "M101", startDate: NSDate.date().dateByAddingTimeInterval(-2 * 60 * 60), endDate: NSDate.date().dateByAddingTimeInterval(-1 * 60 * 60))
    
    // Class that is going on right now
    let currentClass = Class(course: "Course2", type: ClassType.Lecture, location: "V201", startDate: NSDate.date().dateByAddingTimeInterval(-1 * 60 * 30), endDate: NSDate.date().dateByAddingTimeInterval(1 * 60 * 30))
    
    // Future class
    let futureClass = Class(course: "Course3", type: ClassType.Discussion, location: "M108", startDate: NSDate.date().dateByAddingTimeInterval(1 * 60 * 60), endDate: NSDate.date().dateByAddingTimeInterval(2 * 60 * 60))
    
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
    
    func testEquality() {
        var otherClass = currentClass
        
        // Assert equality after assignment
        XCTAssertTrue(currentClass == otherClass, "The two classes should be equal")
        
        // Change course
        otherClass.course = "Other course"
        XCTAssertFalse(currentClass == otherClass, "Classes in different courses should not be equal")
        otherClass.course = currentClass.course
        
        // Change location
        otherClass.location = "M101"
        XCTAssertFalse(currentClass == otherClass, "Classes at different locations should not be equal")
        otherClass.location = currentClass.location
        
        // Change start date
        otherClass.startDate = NSDate.date()
        XCTAssertFalse(currentClass == otherClass, "Classes starting at different times should not be equal")
        otherClass.startDate = currentClass.startDate
        
        // Change end date
        otherClass.endDate = NSDate.date()
        XCTAssertFalse(currentClass == otherClass, "Classes ending at different times should not be equal")
        otherClass.endDate = currentClass.endDate
        
        // Change type
        otherClass.type = ClassType.Discussion
        XCTAssertFalse(currentClass == otherClass, "Classes of different types should not be equal")
        otherClass.type = currentClass.type
        
        // For good measure
        XCTAssertTrue(currentClass == otherClass, "The two classes should be equal")
    }
}
