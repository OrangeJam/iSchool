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
        let assignments = [
            Assignment(attrs: ["12.12.2014 22:22", "Óskilað", "asdfsf", "asdfsfd", "Kúkur", "Penis"]),
            Assignment(attrs: ["12.12.2014 22:22", "asdfsa", "asdfsf", "asdfsfd", "Kúkur", "Vajin"]),
            Assignment(attrs: ["12.12.2014 22:22", "asdfsa", "asdfsf", "asdfsfd", "Kúkur", "Vegans"])
        ]
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
        if let networkClient = getNetworkClient() {
            networkClient.fetchPage(Page.Assignments,
                successHandler: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                    let responseData = NSData(data: response as NSData)
                    self.assignments = Parser.parseAssignments(responseData)
                    NSNotificationCenter.defaultCenter().postNotificationName(Notification.assignment.rawValue, object: nil)
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
        if let networkClient = getNetworkClient() {
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
        }
    }
}
