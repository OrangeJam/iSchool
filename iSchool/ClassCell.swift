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
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let startString = dateFormatter.stringFromDate(c.startDate)
        let endString = dateFormatter.stringFromDate(c.endDate)
        
        // Set the label texts.
        courseLabel.text = c.course
        locationLabel.text = c.location
        typeLabel.text = c.type.toRaw()
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
        
        // Alpha and animation.
        if c.isOver() {
            self.contentView.alpha = 0.3
        } else if c.isNow() {
            /*// Calculate how far down the cell the mask and line layers should be.
            let classDuration = c.endDate.timeIntervalSinceDate(c.startDate)
            let classTime = NSDate.date().timeIntervalSinceDate(c.startDate)
            let ratio = classTime/classDuration
            let layerHeight = floor(Float(ratio) * Float(self.bounds.size.height))
            
            // Create mask layer.
            var maskLayer = CALayer()
            maskLayer.anchorPoint = self.bounds.origin
            maskLayer.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, layerHeight + 1)
            maskLayer.backgroundColor = CGColorCreateCopyWithAlpha(UIColor.whiteColor().CGColor, 0.7)
            
            // Create line layer.
            var lineLayer = CALayer()
            lineLayer.anchorPoint = CGPointMake(self.bounds.origin.x, self.bounds.origin.y - layerHeight - 1)
            lineLayer.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y + layerHeight, self.bounds.size.width, 1)
            lineLayer.backgroundColor = UIColor.redColor().CGColor
            
            // Add mask an line layers.
            self.layer.addSublayer(maskLayer)
            self.layer.addSublayer(lineLayer)
            
            // Add animation.
            let duration = classDuration - classTime
            var lineAnimation = CABasicAnimation(keyPath: "position")
            lineAnimation.fromValue = lineLayer.valueForKey("position")
            lineAnimation.toValue = NSValue(CGPoint: CGPointMake(self.bounds.origin.x, self.bounds.size.height - layerHeight - 2))
            lineAnimation.duration = duration
            lineAnimation.delegate = self
            
            var maskAnimation = CABasicAnimation(keyPath: "bounds.size")
            maskAnimation.fromValue = maskLayer.valueForKey("bounds.size")
            maskAnimation.toValue = NSValue(CGSize: CGSizeMake(self.bounds.size.width, self.bounds.size.height - 2))
            maskAnimation.duration = duration
            maskAnimation.delegate = self
            
            lineLayer.addAnimation(lineAnimation, forKey: "position")
            maskLayer.addAnimation(maskAnimation, forKey: "bounds.size")*/
        } else {
            self.contentView.alpha = 1.0
        }
    }
}
