//
//  MoreMenuController.swift
//  iSchool
//
//  Created by Kári Helgason on 03/11/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

class MoreMenuController: UITableViewController, UITableViewDelegate {
    
    override func viewDidLoad() {
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        switch(indexPath.row) {
        case 2:
            println("Logout")
            logOutUser()
        default:
            println("HEHE flippari selectaði röð")
        }
    }
    
    func logOutUser() {
        CredentialManager.sharedInstance.clearCredentials()
        if let tabbar = self.tabBarController as? MainTabBarController {
            tabbar.presentLoginView()
        }
    }
}
