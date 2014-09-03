//
//  Parser.swift
//  iSchool
//
//  Created by Kári Helgason on 03/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

struct Assignment {
    var dueDate             = NSDate()
    var handedIn            = false
    var courseName          = ""
    var courseIdentifier    = ""
    var URL                 = ""
    var name                = ""
    
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
        URL = attrs[4]
        name = attrs[5]
    }
}

class Parser {
    
    class func parseAssignments(data: NSData) -> [Assignment]{
        let parser = TFHpple.hppleWithHTMLData(data)
        var assignments: [Assignment] = []
        let xpathQuery = "//table[@class='ruTable'][1]/tbody/tr[@class!='ruTableTitle']"
        var nodes = parser.searchWithXPathQuery(xpathQuery) as [TFHppleElement]
        // Ignore empty row at the end of table.
        nodes.removeLast()
        // Fun times ahead
        for node in nodes {
            var attributes: [String] = []
            if node.hasChildren() {
                for child in node.children as [TFHppleElement] {
                    if let text = child.text() {
                        attributes.append(text)
                    }
                    if child.hasChildren() {
                        for child in child.children as [TFHppleElement] {
                            if let link = child.objectForKey("href") {
                                attributes.append(link)
                            }
                            if let text = child.text() {
                                attributes.append(text)
                            }
                        }
                    }
                }
            }
            assignments.append(Assignment(attrs: attributes))
        }
        return assignments
    }
}
