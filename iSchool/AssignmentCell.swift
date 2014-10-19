//
//  AssignmentCell.swift
//  iSchool
//
//  Created by Kári Helgason on 19/10/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import Foundation

class AssignmentsTableViewCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var doneImage: UIImageView!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    func setAssignment(a: Assignment) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        dueDateLabel.text = dateFormatter.stringFromDate(a.dueDate)
        nameLabel.text = a.name
        courseLabel.text = a.courseName
        if a.handedIn {
            doneImage.hidden = false
        }
    }
    
}