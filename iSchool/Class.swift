//
//  Class.swift
//  iSchool
//
//  Created by Björn Orri Sæmundsson on 04/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

enum ClassType : String {
    case Lecture = "Fyrirlestur"
    case Discussion = "Dæmatími"
    case Assistance = "Viðtalstími"
    case Exam = "Próf"
    case Other = "Annað"
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

func == (rhs: Class, lhs: Class) -> Bool {
    if(rhs.course != lhs.course) {
        return false
    }
    if(rhs.startDate != lhs.startDate) {
        return false
    }
    if(rhs.endDate != lhs.endDate) {
        return false
    }
    if(rhs.location != lhs.location) {
        return false
    }
    if(rhs.type != lhs.type) {
        return false
    }
    return true
}