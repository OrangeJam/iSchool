//
//  GradeDetailViewController.swift
//  iSchool
//
//  Created by Starkadur Hrobjartsson on 27.10.2014.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

class GradeDetailViewController : UIViewController, UIWebViewDelegate {
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var webView: UIWebView!
    
    var grade : Grade?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPage()
    }
    
    func setAssignment(g: Grade) {
        grade = g
        navigationItem.title = g.name
    }
    
    func loadPage() {
        let baseUrl = "https://myschool.ru.is/myschool/"
        if let g = grade {
            let url = NSURL(string: baseUrl + g.URL)
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
