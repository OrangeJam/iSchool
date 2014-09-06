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
                for column in columns as [TFHppleElement] {
                    if column.childrenWithTagName("span").count > 0 {
                        for classSpan in column.childrenWithTagName("span") as [TFHppleElement] {
                            // Need this stupid double cast...
                            if let infoString = classSpan.attributes["title"] as? NSString as? String{
                                NSLog(infoString)
                            }
                        }
                    }
                }
            }
        }
        return classes
    }
}
