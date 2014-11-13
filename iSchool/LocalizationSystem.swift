//
//  LocalizationSystem.swift
//  iSchool
//
//  Created by Starkadur Hrobjartsson on 13.11.2014.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

private let _localizer = LocalizationSystem()

class LocalizationSystem {
    
    var bundle: NSBundle
    
    class var sharedInstance: LocalizationSystem {
        return _localizer
    }
    
    func localizedStringForKey(key: String, comment: String) -> String {
        return bundle.localizedStringForKey(key: key, value: comment, table: nil)
    }
    
    func setLanguage(language: String) {
        if let path = NSBundle.mainBundle().pathForResource(name: language, ofType: "lproj") {
            bundle = NSBundle(path: path)
        } else {
            self.resetLocalization()
        }
    }
    
    func resetLocalization() {
        bundle = NSBundle.mainBundle()
    }
    
    func getLanguage() -> String {
        let languages = NSUserDefaults.standardUserDefaults().objectForKey(defaultName: "AppleLanguages")
        let preferredLanguage = languages[0]
        return preferredLanguage
    }
}
