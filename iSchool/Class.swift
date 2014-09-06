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

    var course = ""
    var type: ClassType
    var location = ""
    var startDate = NSDate()
    var endDate = NSDate()
    
    func isOver() -> Bool {
        return false
    }
    
    func isNow() -> Bool {
        return false
    }
}