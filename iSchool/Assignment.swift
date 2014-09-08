//
//  Assignment.swift
//  iSchool
//
//  Created by Kári Helgason on 06/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import Foundation

struct Assignment {
    var dueDate             = NSDate()
    var handedIn            = false
    var courseName          = ""
    var courseIdentifier    = ""
    var URL                 = ""
    var name                = ""
    
    // I wish I had a better way to do this
    init(attrs: [String]){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        if let parsedDate = dateFormatter.dateFromString(attrs[0]) {
            dueDate = parsedDate
        }
        if attrs[1] != "Óskilað" {
            handedIn = true
        }
        courseName = attrs[2]
        courseIdentifier = attrs[3]
        URL = attrs[4]
        name = attrs[5]
    }
}