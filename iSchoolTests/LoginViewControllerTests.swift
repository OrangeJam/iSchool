//
//  LoginViewControllerTests.swift
//  iSchool
//
//  Created by Björn Orri Sæmundsson on 28/08/14.
//  Copyright (c) 2014 OrangeJam. All rights reserved.
//

import iSchool
import UIKit
import XCTest

class LoginViewControllerTests: XCTestCase {

    var viewController: LoginViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as LoginViewController
        viewController.loadView()
        viewController.viewDidLoad()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testLoginButtonConnection() {
        XCTAssertNotNil(viewController.loginButton, "Login button not connected")
    }

}
