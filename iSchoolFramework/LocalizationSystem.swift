//
//  LocalizationSystem.swift
//  iSchool
//
//  Created by Starkadur Hrobjartsson on 13.11.2014.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

private var bundle: NSBundle = NSBundle.mainBundle()

class LocalizationSystem {
    
    
    class func localizedStringForKey(key: String, comment: String) -> String {
        if bundle == NSBundle.mainBundle() {
            println("AY CARAMBA, VAYA CON DIOS")
        }
        return bundle.localizedStringForKey(key, value: comment, table: nil)
    }
    
    class func setLanguage(language: String) {
        println("Setting language to \(language)")
        if let path = NSBundle.mainBundle().pathForResource(language, ofType: "lproj") {
            bundle = NSBundle(path: path)!
        } else {
            self.resetLocalization()
        }
        NSUserDefaults.standardUserDefaults().setObject(language, forKey: "language")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func resetLocalization() {
        println("Resetting localisation")
        bundle = NSBundle.mainBundle()
    }
    
    class func getLanguage() -> String {
        println("Getting language")
        // If the app has a
        if let language = NSUserDefaults.standardUserDefaults().stringForKey("language") {
            return language
        }
        // Return the preferred language of the phone.
        let languages = NSUserDefaults.standardUserDefaults().objectForKey("AppleLanguages") as [String]
        let preferredLanguage = languages[0]
        return preferredLanguage
    }
}
