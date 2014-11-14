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
    
    var numberFormatter: NSNumberFormatter {
        let formatter = NSNumberFormatter()
        formatter.locale = NSLocale.autoupdatingCurrentLocale()
        formatter.numberStyle = .DecimalStyle
        formatter.maximumFractionDigits = 2
        
        return formatter
    }


    func gradeToString(g : Float) -> String {
        if g != -1 {
            return numberFormatter.stringFromNumber(g)!
        }
        return ""
    }

    func extractRank(s : String) -> String {
        let localizer = LocalizationSystem.sharedInstance
        var rank = ""
        
        if s.rangeOfString("Röð") != nil {
            let parts = s.componentsSeparatedByString(":")
            // TODO: Do something to get the right text in the right language in front of rank.
            rank += localizer.localizedStringForKey("Rank: ", comment: "The rank of the grade compared to the grade of other students")
            for var i = 1; i < parts.count; ++i {
                rank += parts[i] + " "
            }
        }
        
        return rank
    }
    
    func SetGrade(g: Grade) {
        nameLabel.text = g.name
        gradeLabel.text = gradeToString(g.grade)
        rankLabel.text = extractRank(g.rank)
        
    }
}