//
//  LoginViewController.swift
//  iSchool
//
//  Created by Björn Orri Sæmundsson on 28/08/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidAppear(animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    @IBAction func didPressLoginButton(sender: UIButton) {
        messageLabel.hidden = true
        dismissKeyboard()
        let username = usernameField.text
        let password = passwordField.text
        let credentialManager = CredentialManager.sharedInstance
        let networkClient = NetworkClient(username: username, password: password);
        NSLog("Button pressed")
        activityIndicator.startAnimating()
        networkClient.fetchPage(Page.Assignments,
            successHandler: authenticationSucceeded,
            errorHandler: authenticationFailed
        )
    }
    
    func registerForKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardWillAppear:",
            name: UIKeyboardWillShowNotification,
            object: nil
        )
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardWillDisappear:",
            name: UIKeyboardWillHideNotification,
            object: nil
        )
    }
    
    func keyboardWillAppear(notification: NSNotification) {
        if let info: NSDictionary = notification.userInfo {
            var value: NSValue = info[UIKeyboardFrameBeginUserInfoKey] as NSValue
            var keyboardRect = value.CGRectValue()
            var keyboardSize = keyboardRect.size
            var contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        
            var aRect = self.view.frame
            aRect.size.height -= keyboardSize.height
        
            if !CGRectContainsPoint(aRect, CGPoint(x: 0, y: loginButton.frame.origin.y + loginButton.frame.height + 6)) {
                let scrollPoint = CGPoint(x: 0, y: loginButton.frame.origin.y + loginButton.frame.size.height - aRect.height + 6)
                scrollView.setContentOffset(scrollPoint, animated: true)
            }
        }
    }
    
    func keyboardWillDisappear(notification: NSNotification) {
        let scrollPoint = CGPoint(x: 0, y: 0)
        scrollView.setContentOffset(scrollPoint, animated: true)
    }
    
    func authenticationSucceeded(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void {
        activityIndicator.stopAnimating()
        NSLog("Success")
        let credentialManager = CredentialManager.sharedInstance
        credentialManager.storeCredentials(usernameField.text, passwordField.text)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func authenticationFailed(operation: AFHTTPRequestOperation!, error: NSError!) -> Void {
        activityIndicator.stopAnimating()
        if let response = operation.response {
            let statusCode = response.statusCode
            switch(statusCode) {
            case 401:
                messageLabel.text = "Invalid username or password, try again."
            default:
                messageLabel.text = "Network error."
            }
        } else {
            messageLabel.text = "Network error."
        }
        messageLabel.hidden = false
    }
    
    func clearFields() -> Void {
        usernameField.text = ""
        passwordField.text = ""
    }
    
    override func viewDidLoad() {
        NSLog("login screen")
        super.viewDidLoad()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        scrollView.addGestureRecognizer(tapRecognizer)
    }
    
    func dismissKeyboard() {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    @IBAction func textFieldDidEndEditing(sender: UITextField) {
        if sender == usernameField {
            passwordField.becomeFirstResponder()
        } else {
            sender.resignFirstResponder()
        }
    }
}