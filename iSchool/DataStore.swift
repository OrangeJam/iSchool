//
//  DataStore.swift
//  iSchool
//
//  Created by Kári Helgason on 08/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

private let _dataStore = DataStore()

enum Notification: String {
    case classes = "DataStoreDidFinishLoadingClassesNotification"
    case assignment = "DataStoreDidFinishLoadingAssignmentsNotification"
    case networkError = "DataStoreDidEncounterNetworkErrorNotification"
}

class DataStore {
    
    private var assignments: [Assignment] = []
    private var classes: [Class] = []
    
    class var sharedInstance: DataStore {
        return _dataStore
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
    
    func getAssignments() -> [Assignment] {
        return assignments
    }
    
    func getClasses() -> [Class] {
        return classes
    }
    
    func fetchAssignments() {
        if let networkClient = getNetworkClient() {
            networkClient.fetchPage(Page.Assignments,
                successHandler: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                    let responseData = NSData(data: response as NSData)
                    self.assignments = Parser.parseAssignments(responseData)
                    NSNotificationCenter.defaultCenter().postNotificationName(Notification.assignment.toRaw(), object: nil)
                },
                errorHandler: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    NSLog("Error: \(error.description)")
                    NSNotificationCenter.defaultCenter().postNotificationName(Notification.networkError.toRaw(), object: nil)
                }
            )
        } else {
            NSLog("Could not get network client")
        }
    }
    
    func fetchClasses() {
        if let networkClient = getNetworkClient() {
            networkClient.fetchPage(Page.Assignments,
                successHandler: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                    let responseData = NSData(data: response as NSData)
                    self.classes = Parser.parseClasses(responseData)
                    NSNotificationCenter.defaultCenter().postNotificationName(Notification.classes.toRaw(), object: nil)
                },
                errorHandler: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    NSLog("Error: \(error.description)")
                    NSNotificationCenter.defaultCenter().postNotificationName(Notification.networkError.toRaw(), object: nil)
                }
            )
        } else {
            NSLog("Could not get network client")
        }
    }
}
