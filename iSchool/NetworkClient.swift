//
//  NetworkClient.swift
//  iSchool
//
//  Created by Kári Helgason on 03/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

enum Page : String {
    case Assignments = "https://myschool.ru.is/myschool/?Page=Exe&ID=1.12"
    case Timetable = "https://myschool.ru.is/myschool/?Page=Exe&ID=3.2"
    case Canteen = "http://malid.ru.is"
}

class NetworkClient {
    
    let manager = AFHTTPRequestOperationManager()
    let timeoutInterval = NSTimeInterval(10)
    
    init(username: String, password: String){
        manager.requestSerializer.setAuthorizationHeaderFieldWithUsername(username, password: password)
    }
    
    
    func fetchPage(page: Page, successHandler:(AFHTTPRequestOperation!, AnyObject!) -> Void,
        errorHandler:(AFHTTPRequestOperation!, NSError!) -> Void) {
        let data = manager.GET(page.toRaw(), parameters: nil,
            success: successHandler,
            failure: errorHandler
        )
    }
    
}