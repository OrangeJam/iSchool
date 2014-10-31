//
//  GradeCell.swift
//  iSchool
//
//  Created by Starkadur Hrobjartsson on 19.10.2014.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//


class GradesTableViewCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!

    
    func SetGrade(g: Grade) {
        nameLabel.text = g.name
        gradeLabel.text = g.gradeString
        rankLabel.text = g.order // TODO: Remove "Röð: " to be able to change language
    }
}