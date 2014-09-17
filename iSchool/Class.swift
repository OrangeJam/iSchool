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
