//
//  MoreMenuController.swift
//  iSchool
//
//  Created by Kári Helgason on 03/11/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

class MoreMenuController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        // Set localized cell titles.
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        switch(indexPath.row) {
        case 0:
            println("HMMM ég er forvitin um hvað sé nú eiginlega í málinu!?!?")
            presentFoodView()
        case 1:
            toggleLanguage()
        case 2:
            println("Logout")
            logOutUser()
        default:
            println("HEHE flippari selectaði röð")
        }
    }
    
    func toggleLanguage() {
        println("Changing language")
        let localizer = LocalizationSystem.sharedInstance
        if localizer.getLanguage() == "is-IS" {
            localizer.setLanguage("en")
            println("Now in English!")
        } else if localizer.getLanguage() == "en" {
            localizer.setLanguage("is-IS")
            println("Now in Icelandic!")
        }
    }
    
    func logOutUser() {
        CredentialManager.sharedInstance.clearCredentials()
        if let tabbar = self.tabBarController as? MainTabBarController {
            tabbar.presentLoginView()
        }
    }
    
    func presentFoodView() {
        if let detail = self.storyboard?.instantiateViewControllerWithIdentifier("FoodWebView") as? FoodWebViewController {
            let bbItem = UIBarButtonItem(title: NSLocalizedString("Back", comment: "Back button in view for Cantine"), style: .Plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = bbItem
            navigationController?.pushViewController(detail, animated: true)
        }
    }
}
