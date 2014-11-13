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
    
    var url: NSURL?
    var progressBar: UIProgressView?
    var webView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Don't put stuff under navigation bar
        edgesForExtendedLayout = UIRectEdge.None
        initializeWebView()
        self.view.addSubview(webView!)
        self.view.addSubview(progressBar!)
    }
    
    func initializeWebView() {
        webView = WKWebView()
        progressBar = UIProgressView()
        webView!.navigationDelegate = self
        webView!.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
        let navbarHeight = self.navigationController != nil ? self.navigationController!.navigationBar.frame.height : 0
        let tabbarHeight = self.tabBarController != nil ? self.tabBarController!.tabBar.frame.height : 0
        webView?.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - tabbarHeight - navbarHeight)
        println(self.bottomLayoutGuide)
        progressBar?.frame = CGRectMake(0, 0, self.view.frame.width, CGFloat(5))
        webView?.hidden = true
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadPage()
    }
    
    override func viewDidDisappear(animated: Bool) {
        webView?.removeObserver(self, forKeyPath: "estimatedProgress")
        super.viewDidDisappear(animated)
    }
    
    func setDetailForURL(url: NSURL, title: String) {
        self.url = url
        navigationItem.title = title
    }
    
    func doneLoading() {
        webView?.hidden = false
        progressBar?.hidden = true
    }
    
    func loadPage() {
        if let url = self.url {
            let req = NSMutableURLRequest(URL: url)
            self.webView!.loadRequest(req)
        }
    }
    
    func prettifyPage() {
        if let jsPath = NSBundle.mainBundle().pathForResource("assignmentPrettifier", ofType: "js") {
            let js = NSString(contentsOfFile: jsPath, encoding: NSUTF8StringEncoding, error: nil)
            webView!.evaluateJavaScript(js!) { (obj, error) in
                self.doneLoading()
            }
        }
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == "estimatedProgress" && object as? NSObject == self.webView {
            if let progress = self.webView?.estimatedProgress {
                println("Progress: \(progress)")
                progressBar?.setProgress(Float(progress), animated: true)
            }
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
 
    // MARK: - WebView delegate
    
    func webView(webView: WKWebView!, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge!, completionHandler: ((NSURLSessionAuthChallengeDisposition, NSURLCredential!) -> Void)!) {
        if let (user,pass) = CredentialManager.sharedInstance.getCredentials() {
            let creds = NSURLCredential(user: user, password: pass, persistence: .None)
            completionHandler(.UseCredential, creds)
        }
    }
    
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        println("Started!!")
    }
    
    func webView(webView: WKWebView!, didFinishNavigation navigation: WKNavigation!) {
        prettifyPage()
    }
    
    func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
        println("Webview failed with error: \(error)")
    }
}
