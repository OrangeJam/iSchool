//
//  Grade.swift
//  iSchool
//
//  Created by Kári Helgason on 08/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import Foundation

func gradeFromString(s: String) -> Float {
    let numberFormatter = NSNumberFormatter()
    numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
    numberFormatter.decimalSeparator = ","
    let gradeString = s as NSString
    if gradeString.length > 9 {
        if let g = numberFormatter.numberFromString(gradeString.substringFromIndex(9)) {
            return g
        }
    }
    return -1
}

struct Grade {
    var name: String
    var URL: String
    var grade: Float
    var order: String
    var course: String
    
    init(attrs: [String]){
        grade = gradeFromString(attrs[3])
        course = attrs[0]
        order = attrs[4]
        URL = attrs[1]
        name = attrs[2]
    }
}