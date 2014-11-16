//
//  DataStore.swift
//  iSchool
//
//  Created by Kári Helgason on 08/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

private let _dataStore = DataStore()

enum WeekDay: Int {
    case Sunday = 1
    case Monday = 2
    case Tuesday = 3
    case Wednesday = 4
    case Thursday = 5
    case Friday = 6
    case Saturday = 7
}

enum Notification: String {
    case classes = "DataStoreDidFinishLoadingClassesNotification"
    case assignment = "DataStoreDidFinishLoadingAssignmentsNotification"
    case grade = "DataStoreDidFinishLoadingGradesNotification"
    case networkError = "DataStoreDidEncounterNetworkErrorNotification"
}

class DataStore {
    
    var grades: [[Grade]] = []
    var assignments: [Assignment] = []
    var classes: [Class] = []
    
    class var sharedInstance: DataStore {
        return _dataStore
    }
    
    func getAssignments() -> [Assignment] {
        return assignments
    }
    
    func getGrades() -> [[Grade]] {
        return grades
    }
    
    func getClasses() -> [Class] {
        return classes
    }
    
    func getClassesForDay(day: WeekDay) -> [Class] {
        let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        var dayClasses: [Class] = []
        for c in classes {
            let components = calendar.components(.WeekdayCalendarUnit, fromDate: c.startDate)
            let classDay = components.weekday
            if classDay == day.rawValue {
                dayClasses.append(c)
            }
        }
        return dayClasses
    }
    
    func getClassesForToday() -> [Class] {
        let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        let components = calendar.components(.WeekdayCalendarUnit, fromDate: NSDate())
        let today = components.weekday
        return getClassesForDay(WeekDay(rawValue: today)!)
    }
    
    private func getNetworkClient() -> NetworkClient? {
        let credentialManager = CredentialManager.sharedInstance
        if let (username, password) = credentialManager.getCredentials() {
            let networkClient = NetworkClient(username: username, password: password)
            return networkClient
        } else {
            NSLog("Credentials were nil")
            return nil
        }
    }
    
    func fetchAssignments() {
        let a1 = Assignment(attrs: ["18.11.2014 23:59", "Skilað", "", "Stöðuvélar og reiknanleiki", "?Page=Exe&ID=2.4&ViewMode=2&fagid=26706&verkID=50021", "Assignment 11"])
        let a2 = Assignment(attrs: ["19.11.2014 23:59", "Óskilað", "", "Tölvusamskipti", "?Page=Exe&ID=2.4&ViewMode=2&fagid=26706&verkID=50021", "Extra Assignment"])
        let a3 = Assignment(attrs: ["26.11.2014 23.59", "Óskilað", "", "Tölvusamskipti", "?Page=Exe&ID=2.4&ViewMode=2&fagid=26706&verkID=50021", "Extra Online Exam"])
        assignments = [a1, a2, a3]
        NSNotificationCenter.defaultCenter().postNotificationName(Notification.grade.rawValue, object: nil)
        if let networkClient = getNetworkClient() {
            networkClient.fetchPage(Page.Assignments,
                successHandler: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                    let responseData = NSData(data: response as NSData)
                    if let g = Parser.parseGrades(responseData) {
                        self.grades = g
                    }
                    NSNotificationCenter.defaultCenter().postNotificationName(Notification.grade.rawValue, object: nil)
                },
                errorHandler: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    NSLog("Error: \(error.description)")
                    NSNotificationCenter.defaultCenter().postNotificationName(Notification.networkError.rawValue, object: nil)
                }
            )
        } else {
            NSLog("Could not get network client")
        }
    }
    
    func fetchClasses() {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        
        let start1 = formatter.dateFromString("17.11.2014 11:10")!
        let end1 = formatter.dateFromString("17.11.2014 11:55")!
        let c1 = Class(course: "Stöðuvélar og reiknanleiki", type: ClassType.Lecture, location: "M109", startDate: start1, endDate: end1)
        
        let demoStart = formatter.dateFromString("17.11.2014 13:00")!
        let demoEnd = formatter.dateFromString("17.11.2014 14:00")!
        let demo = Class(course: "UROP kynning", type: ClassType.Other, location: "", startDate: demoStart, endDate: demoEnd)
        
        let start2 = formatter.dateFromString("18.11.2014 13:10")!
        let end2 = formatter.dateFromString("18.11.2014 13:55")!
        let c2 = Class(course: "Tölvusamskipti", type: ClassType.Lecture, location: "V201", startDate: start2, endDate: end2)
        let start3 = formatter.dateFromString("18.11.2014 14:00")!
        let end3 = formatter.dateFromString("18.11.2014 14:45")!
        let c3 = Class(course: "Tölvusamskipti", type: ClassType.Lecture, location: "V201", startDate: start3, endDate: end3)
        
        classes = [c1, demo, c2, c3]
        NSNotificationCenter.defaultCenter().postNotificationName(Notification.classes.rawValue, object: nil)
        
        /*if let networkClient = getNetworkClient() {
            networkClient.fetchPage(Page.Timetable,
                successHandler: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                    let responseData = NSData(data: response as NSData)
                    self.classes = Parser.parseClasses(responseData)
                    NSNotificationCenter.defaultCenter().postNotificationName(Notification.classes.rawValue, object: nil)
                },
                errorHandler: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    NSLog("Error: \(error.description)")
                    NSNotificationCenter.defaultCenter().postNotificationName(Notification.networkError.rawValue, object: nil)
                }
            )
        } else {
            NSLog("Could not get network client")
        }*/
    }
    
    func clearData() {
        grades = []
        assignments = []
        classes = []
    }
}
