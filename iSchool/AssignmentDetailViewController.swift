//
//  AssignmentDetailView.swift
//  iSchool
//
//  Created by Kári Helgason on 19/10/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

class AssignmentDetailViewController : UIViewController, UIWebViewDelegate {

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var webView: UIWebView!
    
    var assignment : Assignment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPage()
    }
    
    func setAssignment(a: Assignment) {
        assignment = a
        navigationItem.title = a.name
    }
    
    func loadPage() {
        let baseUrl = "https://myschool.ru.is/myschool/"
        if let a = assignment {
            let url = NSURL(string: baseUrl + a.URL)
            let req = NSURLRequest(URL: url!)
            self.webView.loadRequest(req)
        }
    }
 
    // MARK: - WebView delegate
    
    func webViewDidStartLoad(webView: UIWebView) {
        //FIXME
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        //FIXME
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        //FIXME
    }
    
    
    
}
