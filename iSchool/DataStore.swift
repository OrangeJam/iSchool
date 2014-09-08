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
    case assignment = "DataStoreDidFinishLoadingAssignmentsNotification"
    case networkError = "DataStoreDidEncounterNetworkErrorNotification"
}

class DataStore {
    
    private var assignments: [Assignment] = []
    
    class var sharedInstance: DataStore {
        return _dataStore
    }
    
    func fetchAssignments() {
        let credentialManager = CredentialManager.sharedInstance
        if let (username, password) = credentialManager.getCredentials() {
            let networkClient = NetworkClient(username: username, password: password)
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
            NSLog("Credentials were nil :(")
        }
    }
    
    func getAssignments() -> [Assignment] {
        return assignments
    }
    
}
