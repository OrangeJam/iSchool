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
    
    class DataStoreMock: DataStore {
        // Fetch classes from test page instead of the real page
        override func fetchClasses() {
            let testDataPath = NSBundle(forClass: ParserTests.self).pathForResource("timetable_normal", ofType: "html")!
            let data = NSData(contentsOfFile: testDataPath)
            classes = Parser.parseClasses(data!)
        }
    }
    
    override func setUp() {
        let filePath = NSBundle(forClass: self.dynamicType).pathForResource("TestCredentials", ofType:"plist")
        let credentials = NSDictionary(contentsOfFile:filePath!)!
        let username = credentials.valueForKey("Username") as String
        let password = credentials.valueForKey("Password") as String
        CredentialManager.sharedInstance.storeCredentials(username, password)
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPostsNotificationOnFetchAssignments() {
        let notificationExpectation = expectationWithDescription("Should recieve notification")
        let observer = NSNotificationCenter.defaultCenter().addObserverForName(
            Notification.assignment.rawValue,
            object: nil,
            queue: NSOperationQueue.mainQueue(),
            usingBlock: { _ in
                NSLog("notification recieved!")
                notificationExpectation.fulfill()
            }
        )
        DataStore.sharedInstance.fetchAssignments()
        waitForExpectationsWithTimeout(10, handler: { _ in
            
        })
        NSNotificationCenter.defaultCenter().removeObserver(observer)
        
    }
    
    func testGetClassesForDay() {
        let STOR = "Stöðuvélar og reiknanleiki"
        let ANDR = "App Development - Android"
        let dataStore = DataStoreMock()
        dataStore.fetchClasses()
        let classes = dataStore.getClassesForDay(WeekDay.Monday)
        XCTAssertEqual(classes.count, 5, "Classes for day not fetched correctly")
        if classes.count == 5 {
            XCTAssertEqual(classes[0].course, STOR, "First class on Monday should be STOR")
            XCTAssertEqual(classes[1].course, STOR, "Second class on Monday should be STOR")
            XCTAssertEqual(classes[2].course, ANDR, "Third class on Monday should be ANDR")
            XCTAssertEqual(classes[3].course, ANDR, "Fourth class on Monday should be ANDR")
            XCTAssertEqual(classes[4].course, ANDR, "Fifth class on Monday should be ANDR")
        } else {
            XCTFail("Could not check individual classes in testGetClassesForDay")
        }
    }
    
    func testGetClassesForToday() {
        let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        let components = calendar.components(.WeekdayCalendarUnit, fromDate: NSDate())
        let today = components.weekday
        
        let dataStore = DataStoreMock()
        dataStore.fetchClasses()
        let classes = dataStore.getClassesForToday()
        for c in classes {
            let classComponents = calendar.components(.WeekdayCalendarUnit, fromDate: c.startDate)
            let classDay = classComponents.weekday
            XCTAssertEqual(today, classDay, "getClassesForToday does not return the correct classes")
        }
    }
}
