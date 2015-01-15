//
//  FoodWebView.swift
//  iSchool
//
//  Created by Kári Helgason on 03/11/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit
import WebKit

class FoodWebViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Don't put stuff under navigation bar
        edgesForExtendedLayout = UIRectEdge.None
        webView = WKWebView()
        webView!.navigationDelegate = self
        navigationItem.title = "Málið"
        
        let navbarHeight = self.navigationController != nil ? self.navigationController!.navigationBar.frame.height : 0
        let tabbarHeight = self.tabBarController != nil ? self.tabBarController!.tabBar.frame.height : 0
        webView?.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - tabbarHeight - navbarHeight)
        
        self.view.addSubview(webView!)
        let url = NSURL(string: "http://malid.ru.is")
        let req = NSMutableURLRequest(URL: url!)
        self.webView!.loadRequest(req)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func prettifyPage() {
        if let jsPath = NSBundle.mainBundle().pathForResource("foodPrettifier", ofType: "js") {
            let js = NSString(contentsOfFile: jsPath, encoding: NSUTF8StringEncoding, error: nil)
            webView!.evaluateJavaScript(js!, nil)
        }
    }
    
    // MARK: WKNavigation delegate
    
    func webView(webView: WKWebView!, didFinishNavigation navigation: WKNavigation!) {
        prettifyPage()
        
    }
}
