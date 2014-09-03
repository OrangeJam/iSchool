//
//  NetworkClient.swift
//  iSchool
//
//  Created by Kári Helgason on 03/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

enum Pages : String {
    case Assignments = "https://myschool.ru.is/myschool/?Page=Exe&ID=1.12"
    case Timetable = "https://myschool.ru.is/myschool/?Page=Exe&ID=3.2"
    case Canteen = "http://malid.ru.is"
}

class NetworkClient {
    
    let manager = AFHTTPRequestOperationManager()
    let timeoutInterval = NSTimeInterval(10)
    
    
    func fetchAssignmentsPageWithSuccessHandler(handler:(AFHTTPRequestOperation!, AnyObject!) -> Void) {
        let data = manager.GET(Pages.Assignments.toRaw(), parameters: nil,
            success: handler,
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                NSLog("Error =/")
            }
        )
    }
    
}