//
//  Assignment.swift
//  iSchool
//
//  Created by Kári Helgason on 06/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import Foundation

private let baseURL = "https://myschool.ru.is/myschool/"

struct Assignment : Equatable {
    var dueDate             = NSDate()
    var handedIn            = false
    var courseName          = ""
    var courseIdentifier    = ""
    var URL                 = ""
    var name                = ""
    var description: String?
    var weight: String?
    var attachedFiles: [String]?
    
    
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
        URL = baseURL + attrs[4]
        name = attrs[5]
    }
}

 // MARK: Equatable

func == (lhs: Assignment, rhs: Assignment) -> Bool {
    return  lhs.dueDate == rhs.dueDate &&
        lhs.handedIn == rhs.handedIn &&
        lhs.courseName == rhs.courseName &&
        lhs.courseIdentifier == rhs.courseIdentifier &&
        lhs.URL == rhs.URL &&
        lhs.name == rhs.name
}