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
        case 0:
            println("HMMM ég er forvitin um hvað sé nú eiginlega í málinu!?!?")
            presentFoodView()
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
    
    func presentFoodView() {
        if let detail = self.storyboard?.instantiateViewControllerWithIdentifier("FoodWebView") as? FoodWebViewController {
            let bbItem = UIBarButtonItem(title: "Back", style: .Plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = bbItem
            navigationController?.pushViewController(detail, animated: true)
        }
    }
}
