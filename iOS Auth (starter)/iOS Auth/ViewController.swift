//
// ViewController.swift
//
// Created by Joey deVilla, October 2021.
// Companion project for the Auth0 blog article
// “Get Started with iOS Authentication Using Swift and UIKit”.
//
// See the end of the file for licensing information.
//

import UIKit


class ViewController: UIViewController {

  // MARK: Properties
  // ================
  
  // On-screen controls
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var logoutButton: UIButton!
  @IBOutlet weak var userInfoMetadataStack: UIStackView!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var userEmailLabel: UILabel!
  @IBOutlet weak var favoriteColorTextField: UITextField!
  
  // App and user status
  
  // Auth0 data
  
  
  // MARK: View events
  // =================

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  // MARK: Actions
  // =============

  @IBAction func loginButtonPressed(_ sender: UIButton) {

  }
  
  @IBAction func logoutButtonPressed(_ sender: UIButton) {

  }
  
  @IBAction func getFavoriteColorButtonPressed(_ sender: UIButton) {

  }
  
  @IBAction func setFavoriteColorButtonPressed(_ sender: UIButton) {

  }
  
  
  // MARK: UI updaters
  // =================

  
  // MARK: Login, logout, and user information
  // =========================================

}


// MARK: Utilities
// ===============

func plistValues(bundle: Bundle) -> (clientId: String, domain: String)? {
  guard
    let path = bundle.path(forResource: "Auth0", ofType: "plist"),
    let values = NSDictionary(contentsOfFile: path) as? [String: Any]
    else {
      print("Missing Auth0.plist file with 'ClientId' and 'Domain' entries in main bundle!")
      return nil
    }

  guard
    let clientId = values["ClientId"] as? String,
    let domain = values["Domain"] as? String
    else {
      print("Auth0.plist file at \(path) is missing 'ClientId' and/or 'Domain' entries!")
      print("File currently has the following entries: \(values)")
      return nil
    }
  
  return (clientId: clientId, domain: domain)
}


//
// License information
// ===================
//
// Copyright (c) 2021 Auth0 (http://auth0.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
