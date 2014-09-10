//
//  Grade.swift
//  iSchool
//
//  Created by Kári Helgason on 08/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import Foundation

struct Grade {
    var name: String
    var URL: String
    var grade: Float
    var order: String
    var course: String
    
    init(attrs: [String]){
        var gradeString = attrs[3] as NSString
        //let startIndex = advance(gradeString.startIndex, 7)
        //let range = startIndex..<gradeString.endIndex   // same as let range = Range(start: startIndex, end: endIndex)
        grade = (gradeString.substringFromIndex(9) as NSString).floatValue
        course = attrs[0]
        order = attrs[4]
        URL = attrs[1]
        name = attrs[2]
    }
}