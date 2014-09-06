//
//  Parser.swift
//  iSchool
//
//  Created by Kári Helgason on 03/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

class Parser {
    
    class func parseAssignments(data: NSData) -> [Assignment] {
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
    
    // Kári, I know you will appreciate the beauty of this function :)
    class func parseClasses(data: NSData) -> [Class] {
        let parser = TFHpple.hppleWithHTMLData(data)
        var classes: [Class] = []
        let xpathQuery = "//div[@class='ruContentPage']/center[1]/table/tbody/tr"
        var nodes = parser.searchWithXPathQuery(xpathQuery) as [TFHppleElement]
        if nodes.count > 0 {
            // Ignore irrelevant nodes (first two and the last)
            nodes.removeLast()
            nodes.removeRange(Range(start:0, end:2))
            
            // Extract and remove the row that holds the dates
            let dateRow = nodes[0]
            nodes.removeAtIndex(0)
            
            // Get the dates in an array
            var dates: [String] = []
            var dateColumns = dateRow.childrenWithTagName("th")
            // Remove first irrelevant  column
            dateColumns.removeAtIndex(0)
            for column in dateColumns as [TFHppleElement] {
                if let text = column.text() {
                    dates.append(text)
                }
            }
            for row in nodes as [TFHppleElement] {
                // Split the row into columns
                var columns = row.childrenWithTagName("td")
                // Extract the column with the start and end time and then remove it
                let timeColumn: TFHppleElement = columns[0] as TFHppleElement
                columns.removeAtIndex(0)
                
                // Extract the strings for the start and end time
                if let timeText = timeColumn.text() {
                    let times = timeText.componentsSeparatedByString(" ") // &nbsp
                    for (index, column) in enumerate(columns as [TFHppleElement]) {
                        if column.childrenWithTagName("span").count > 0 {
                            // Create start and end dates
                            let dateFormatter = NSDateFormatter()
                            dateFormatter.dateFormat = "dd.MM.yyyyHH:mm"
                            if let startDate = dateFormatter.dateFromString(dates[index] + times[0]) {
                                if let endDate = dateFormatter.dateFromString(dates[index] + times[1]) {
                                    // Create each class in this box
                                    for classSpan in column.childrenWithTagName("span") as [TFHppleElement] {
                                        // Need this stupid double cast...
                                        if let infoString = classSpan.attributes["title"] as? NSString as? String{
                                            let info = infoString.componentsSeparatedByString("\n")
                                            let course = info[0]
                                            let typeString = info[2]
                                            var type: ClassType
                                            // Could fetch additional information here...
                                            // Set the type of the class based on the type string
                                            switch(typeString) {
                                                case "Fyrirlestrar":
                                                    type = ClassType.Lecture
                                                case "Dæmatímar":
                                                    type = ClassType.Discussion
                                                case "Viðtalstímar":
                                                    type = ClassType.Assistance
                                                case "Lokapróf":
                                                    type = ClassType.Exam
                                                default:
                                                    type = ClassType.Other
                                            }
                                            // Get the location of the class
                                            // In the old app this part caused crashes, so I'm being extra careful
                                            var location = ""
                                            if let small = classSpan.firstChildWithTagName("a").childrenWithTagName("small").last as? TFHppleElement {
                                                if let children = small.children as? [TFHppleElement] {
                                                    if children.count > 2 {
                                                        if let locationString = small.children[2].content as String! {
                                                            if let locationPart = locationString.componentsSeparatedByString(" ").last {
                                                                location = locationPart
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            // Create the class and append it to the array
                                            let newClass = Class(course: course, type: type, location: location, startDate: startDate, endDate: endDate)
                                            classes.append(newClass)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        let sortedClasses = sorted(classes, {(class1: Class, class2: Class) -> Bool in return class1.startDate.timeIntervalSinceReferenceDate < class2.startDate.timeIntervalSinceReferenceDate})
        for c in sortedClasses {
            NSLog(c.course)
            NSLog(c.location)
            NSLog(toString(c.startDate))
            NSLog(toString(c.endDate))
        }
        return sortedClasses
    }
}
