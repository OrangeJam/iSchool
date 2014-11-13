//
//  MoreMenuController.swift
//  iSchool
//
//  Created by Kári Helgason on 03/11/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

class MoreMenuCell : UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var malidImage: UIImageView!
}

class MoreMenuController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        // Set localized cell titles.
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        switch(indexPath.row) {
        case 0:
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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var labelText: String = ""
        let cell = tableView.dequeueReusableCellWithIdentifier("moreMenuCell") as MoreMenuCell
        switch(indexPath.row) {
        case 0:
            labelText = LocalizationSystem.localizedStringForKey("Málið Cafeteria", comment: "Text on button to view the menu for Málið")
            cell.malidImage.hidden = false
        case 1:
            labelText = NSLocalizedString("LANGUAGE", comment: "Button to change language")
        case 2:
            labelText = LocalizationSystem.localizedStringForKey("Log out", comment: "Log out button")
        default:
            println("Some thing strange is happening in MoreMenu tableView")
        }
        cell.label.text = labelText
        return cell
    }
    
    func toggleLanguage() {
        println("Changing language")
        if LocalizationSystem.getLanguage() == "is-IS" {
            LocalizationSystem.setLanguage("en")
            println("Now in English!")
        } else if LocalizationSystem.getLanguage() == "en" {
            LocalizationSystem.setLanguage("is-IS")
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
