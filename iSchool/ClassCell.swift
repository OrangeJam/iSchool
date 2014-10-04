//
//  ClassCell.swift
//  iSchool
//
//  Created by Björn Orri Sæmundsson on 11/09/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

class ClassCell: UITableViewCell {
    
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var typeImage: UIImageView!
    
    func setClass(c: Class) {
        // Format the date strings
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let startString = dateFormatter.stringFromDate(c.startDate)
        let endString = dateFormatter.stringFromDate(c.endDate)
        
        // Set the label texts
        courseLabel.text = c.course
        locationLabel.text = c.location
        typeLabel.text = c.type.rawValue
        startLabel.text = startString
        endLabel.text = endString
    }
}
