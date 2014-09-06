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

struct Class {

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