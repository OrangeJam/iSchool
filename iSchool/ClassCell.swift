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
        // Format the date strings.
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let startString = timeFormatter.stringFromDate(c.startDate)
        let endString = timeFormatter.stringFromDate(c.endDate)

        
        // Set the label texts.
        courseLabel.text = c.course
        locationLabel.text = c.location
        typeLabel.text = c.type.description
        startLabel.text = startString
        endLabel.text = endString
        
        // Set the image.
        var imageName: String!
        switch(c.type) {
        case ClassType.Lecture:
            imageName = "lecture.png"
        case ClassType.Discussion:
            imageName = "lab.png"
        case ClassType.Assistance:
            imageName = "help.png"
        default:
            imageName = "rulogo.png"
        }
        typeImage.image = UIImage(named: imageName)
    }
}
