//
//  Grade.swift
//  iSchool
//
//  Created by Kári Helgason on 08/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import Foundation

func gradeToFloat(s: String) -> Float {
    let parts = s.componentsSeparatedByString(" ")
    if parts.count > 1 {
        let gradePart = parts[parts.count - 1]
        let floatString = gradePart.stringByReplacingOccurrencesOfString(",", withString: ".", options: NSStringCompareOptions.LiteralSearch, range: nil)
        return (floatString as NSString).floatValue
    }
    return -1
}

func gradeToString(s: String) -> String {
    let parts = s.componentsSeparatedByString(" ")
    if parts.count > 1 {
        let gradePart = parts[parts.count - 1]
        return gradePart
    }
    return ""
}

func prettifyCourse(s: String) -> String {
    let parts = s.componentsSeparatedByString(" ")
    var course = ""
    if parts.count > 1 {
        for var i = 1; i < parts.count; ++i {
            course += parts[i] + " "
        }
    }
    
    return course
}

struct Grade {
    var name: String
    var URL: String
    var grade: Float
    var gradeString: String
    var order: String
    var course: String
    
    
    init(attrs: [String]){
        grade = gradeToFloat(attrs[3])
        gradeString = gradeToString(attrs[3])
        course = prettifyCourse(attrs[0])
        order = attrs[4]
        URL = attrs[1]
        name = attrs[2]
    }
}