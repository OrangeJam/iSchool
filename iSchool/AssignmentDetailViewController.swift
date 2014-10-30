//
//  AssignmentDetailView.swift
//  iSchool
//
//  Created by Kári Helgason on 19/10/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit
import WebKit

class AssignmentDetailViewController : UIViewController, WKNavigationDelegate {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var assignment : Assignment?
    var webView : WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView = WKWebView()
        self.view = webView!
        webView!.navigationDelegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
        loadPage()
    }
    
    func setAssignment(a: Assignment) {
        assignment = a
        navigationItem.title = a.name
    }
    
    func loadPage() {
        if let a = assignment {
            let url = NSURL(string: a.URL)
            println("Url: \(url)")
            let req = NSMutableURLRequest(URL: url!)
//            if let auth = CredentialManager.sharedInstance.getBase64EncodedAuthString() {
//                req.setValue(auth, forHTTPHeaderField: "Authorization")
//            }
            self.webView!.loadRequest(req)
        }
    }
    
    func prettifyPage() {
        if let jsPath = NSBundle.mainBundle().pathForResource("assignmentPrettifier", ofType: "js") {
            let js = NSString(contentsOfFile: jsPath, encoding: NSUTF8StringEncoding, error: nil)
            webView!.evaluateJavaScript(js!) { (obj, error) in
                println("Ble")
            }
        }
        
    }
 
    // MARK: - WebView delegate
    
    func webView(webView: WKWebView!, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge!, completionHandler: ((NSURLSessionAuthChallengeDisposition, NSURLCredential!) -> Void)!) {
        if let (user,pass) = CredentialManager.sharedInstance.getCredentials() {
            let creds = NSURLCredential(user: user, password: pass, persistence: .None)
            completionHandler(.UseCredential, creds)
        }
    }
    
    func webView(webView: WKWebView!, didFinishNavigation navigation: WKNavigation!) {
        prettifyPage()
    }
    
    
    
}
