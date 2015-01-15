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
        let rocket = UIImageView(image: UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("rocket-100", ofType: "png")!))
        rocket.frame = CGRect(x: tableView.frame.width/2 - 50, y: 230, width: 100, height: 100)
        rocket.alpha = 0.4
        tableView.addSubview(rocket)
        tableView.scrollEnabled = false
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        switch(indexPath.row) {
        case 0:
            presentFoodView()
        case 1:
            println("Logout")
            logOutUser()
        default:
            println("HEHE flippari selectaði röð")
        }
    }
    
    func logOutUser() {
        CredentialManager.sharedInstance.clearCredentials()
        DataStore.sharedInstance.clearData()
        if let tabbar = self.tabBarController as? MainTabBarController {
            tabbar.presentLoginView(true)
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
