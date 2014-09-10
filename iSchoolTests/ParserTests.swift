//
//  ParserTests.swift
//  iSchool
//
//  Created by Kári Helgason on 03/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

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
    
    func testParseAverageAssignments() {
        let data = NSData(contentsOfFile: testDataPath)
        let dueAssignments = Parser.parseAssignments(data)
        XCTAssertEqual(dueAssignments.count, 2, "There should be two assignments")
        XCTAssertEqual(dueAssignments[0].name, "hw1", "The name of the first should be hw1")
        XCTAssertFalse(dueAssignments[1].handedIn, "The second assignment should not be handed in")
    }
    
    func testParseTimetableNormal() {
        let testDataPath = NSBundle(forClass: ParserTests.self).pathForResource("timetable_normal", ofType: "html")!
        let data = NSData(contentsOfFile: testDataPath)
        let classes = Parser.parseClasses(data)
        
        // Test if all classes were parsed
        XCTAssertEqual(classes.count, 20, "There should be 22 classes")
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        
        // Test the class at index 6
        if(classes.count > 6) {
            let startDate = dateFormatter.dateFromString("02.09.2014 13:10")
            let endDate = dateFormatter.dateFromString("02.09.2014 13:55")
            XCTAssertEqual(classes[6].course, "Tölvusamskipti", "The course name of the class at index 6 should be Tölvusamskipti")
            XCTAssertEqual(classes[6].type, ClassType.Lecture, "The course at index 6 should be a lecture")
            XCTAssertEqual(classes[6].location, "V201", "The location of the course at index 6 should be V201")
            XCTAssertEqual(classes[6].startDate, startDate!, "The class at index 6 should start at 02.09.2014 13:10")
            XCTAssertEqual(classes[6].endDate, endDate!, "The class at index 6 should end at 02.09.2014 13:55")
        } else {
            XCTFail("Could not test class at index 6")
        }
        
        // Test the class at index 7
        if(classes.count > 7) {
            let startDate = dateFormatter.dateFromString("03.09.2014 13:10")
            let endDate = dateFormatter.dateFromString("03.09.2014 13:55")
            XCTAssertEqual(classes[7].course, "Stærðfræði I", "The course name of the class at index 7 should be Stærðfræði I")
            XCTAssertEqual(classes[7].type, ClassType.Discussion, "The class at index 7 should be a discussion class")
            XCTAssertEqual(classes[7].location, "V105", "The location of the course at index 8 should be V105")
            XCTAssertEqual(classes[7].startDate, startDate!, "The class at index 7 should start at 03.09.2014 13:10")
            XCTAssertEqual(classes[7].endDate, endDate!, "The class at index 7 should end at 02.09.2014 13:55")
        } else {
            XCTFail("Could not test class at index 8")
        }
    }
    
    func testParseTimetableExams() {
        let testDataPath = NSBundle(forClass: ParserTests.self).pathForResource("timetable_exams", ofType: "html")!
        let data = NSData(contentsOfFile: testDataPath)
        let classes = Parser.parseClasses(data)
        
        // Test if all classes (exams) were parsed
        XCTAssertEqual(classes.count, 8, "There should be 8 classes (exams)")
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        
        // Test the class at index 2
        if(classes.count > 2) {
            let startDate = dateFormatter.dateFromString("08.04.2014 15:45")
            let endDate = dateFormatter.dateFromString("08.04.2014 16:30")
            XCTAssertEqual(classes[2].course, "Forritunarmál", "The course name of the class (exam) at index 2 should be Forritunarmál")
            XCTAssertEqual(classes[2].type, ClassType.Exam, "The class (exam) at index 2 should have the type Exam")
            XCTAssertEqual(classes[2].location, "M201", "The class (exam) at index 2 should have the location M201")
            XCTAssertEqual(classes[2].startDate, startDate!, "The class (exam) at index 2 should start at 08.04.2014 15:45")
            XCTAssertEqual(classes[2].endDate, endDate!, "The class (exam) at index 2 should end at 08.04.2014 16:30")
        } else {
            XCTFail("Could not test class (exam) at index 2")
        }
        
        // Test the class at index 6
        if(classes.count > 6) {
            let startDate = dateFormatter.dateFromString("11.04.2014 15:45")
            let endDate = dateFormatter.dateFromString("11.04.2014 16:30")
            XCTAssertEqual(classes[6].course, "Hugbúnaðarfræði II", "The course name of the class (exam) at index 6 should be Hugbúnaðarfræði II")
            XCTAssertEqual(classes[6].type, ClassType.Exam, "The class (exam) at index 6 should have the type Exam")
            XCTAssertEqual(classes[6].location, "M101", "The class (exam) at index 6 should have the location M101")
            XCTAssertEqual(classes[6].startDate, startDate!, "The class (exam) at index 6 should start at 08.04.2014 15:45")
            XCTAssertEqual(classes[6].endDate, endDate!, "The class (exam) at index 6 should end at 08.04.2014 16:30")
        } else {
            XCTFail("Could not test class (exam) at index 6")
        }
    }
}
