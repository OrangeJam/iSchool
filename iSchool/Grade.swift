//
//  Grade.swift
//  iSchool
//
//  Created by Kári Helgason on 08/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import Foundation

var numberFormatter: NSNumberFormatter {
    let formatter = NSNumberFormatter()
    formatter.numberStyle = .DecimalStyle
    formatter.maximumFractionDigits = 2
    
    return formatter
}

func gradeFromString(s: String) -> Float {
    let parts = s.componentsSeparatedByString(" ")
    if parts.count > 1 {
        let gradePart = parts[parts.count - 1]
        println(gradePart)
        let floatString = gradePart.stringByReplacingOccurrencesOfString(",", withString: ".", options: NSStringCompareOptions.LiteralSearch, range: nil)
        println(floatString)
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
    var rank: String
    var course: String
    
    
    init(attrs: [String]){
        grade = gradeFromString(attrs[3])
        course = prettifyCourse(attrs[0])
        rank = attrs[4]
        URL = attrs[1]
        name = attrs[2]
    }
}