//
//  Class.swift
//  iSchool
//
//  Created by Björn Orri Sæmundsson on 04/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit
import Foundation

enum ClassType : String {
    case Lecture = "Lecture"
    case Discussion = "Discussion"
    case Assistance = "Assistance"
    case Exam = "Exam"
    case Other = "Other"
    
    var description : String {
        get {
            return NSLocalizedString(self.rawValue, comment: self.rawValue)
        }
    }
}


struct Class: Equatable {
    
    var course: String
    var type: ClassType
    var location: String
    var startDate: NSDate
    var endDate: NSDate
    
    
    func isOver() -> Bool {
        return endDate.timeIntervalSinceNow <= 0.0
    }
    
    func isNow() -> Bool {
        return startDate.timeIntervalSinceNow <= 0.0 && endDate.timeIntervalSinceNow > 0.0
    }
}

func == (lhs: Class, rhs: Class) -> Bool {
    if(lhs.course != rhs.course) {
        return false
    }
    if(lhs.startDate != rhs.startDate) {
        return false
    }
    if(lhs.endDate != rhs.endDate) {
        return false
    }
    if(lhs.location != rhs.location) {
        return false
    }
    if(lhs.type != rhs.type) {
        return false
    }
    return true
}

// 💩💩💩 This is some ugly hack to make the localization for the strings in ClassType work 
// There has to be a better way but I found none.
func NotAFunction() {
    let Lecture = NSLocalizedString("Lecture", comment: "The word Lecture in the timeTable")
    let Discussion = NSLocalizedString("Discussion", comment: "The word Discussion in the timeTable")
    let Assistance = NSLocalizedString("Assistance", comment: "The word Assistance in the timeTable")
    let Exam = NSLocalizedString("Exam", comment: "The word Exam in the timeTable")
    let Other = NSLocalizedString("Other", comment: "The word Other in the timeTable")
}
