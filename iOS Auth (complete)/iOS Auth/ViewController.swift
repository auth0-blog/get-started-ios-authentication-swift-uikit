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
import Auth0


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
  private var appJustLaunched = true
  private var userIsAuthenticated = false
  private var userIsNewlyAuthenticated = false
  
  // Auth0 data
  private var cachedCredentials: Credentials? = nil
  private var cachedUserInfo: UserInfo? = nil
  private var cachedUserMetadata: [String : Any]? = nil
  private var cachedAppMetadata: [String : Any]? = nil
  
  
  // MARK: View events
  // =================

  override func viewDidLoad() {
    super.viewDidLoad()
        
    updateTitle()
    userInfoMetadataStack.isHidden = true
    loginButton.isEnabled = true
    logoutButton.isEnabled = false
  }
  
  
  // MARK: Actions
  // =============

  @IBAction func loginButtonPressed(_ sender: UIButton) {
    if !userIsAuthenticated {
      login()
    }
  }
  
  @IBAction func logoutButtonPressed(_ sender: UIButton) {
    if userIsAuthenticated {
      logout()
    }
  }
  
  @IBAction func getFavoriteColorButtonPressed(_ sender: UIButton) {
    getMetadata()
  }
  
  @IBAction func setFavoriteColorButtonPressed(_ sender: UIButton) {
    updateFavoriteColor()
  }
  
  
  // MARK: UI updaters
  // =================

  func updateTitle() {
    if appJustLaunched {
      titleLabel.text = "Welcome to the app!"
      appJustLaunched = false
    } else {
      if userIsAuthenticated {
        titleLabel.text = "You’re logged in."
      } else {
        titleLabel.text = "You’re logged out."
      }
    }
  }

  func updateButtonsAndStack() {
    loginButton.isEnabled = !userIsAuthenticated
    logoutButton.isEnabled = userIsAuthenticated
    userInfoMetadataStack.isHidden = !userIsAuthenticated
  }
  
  func updateNameAndEmailUI() {
    userNameLabel.text = cachedUserInfo?.name ?? "[Name unknown]"
    userEmailLabel.text = cachedUserInfo?.email ?? "[Email unknown]"
  }
  
  func updateFavoriteColorUI() {
    favoriteColorTextField.text = cachedUserMetadata?["favorite_color"] as? String ?? ""
  }
  
  func showOptionalAnnouncement() {
    if let makeAnnouncement = cachedAppMetadata?["make_announcement"] as? Int {
      if makeAnnouncement != 0 {
        let title = "Announcement"
        let message = "If you’re seeing this, it means that the ’make_announcement’ " +
                      "flag in ’app_data’ is set to ’true’."
        let alert = UIAlertController(
          title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
      }
    }
  }
  
  
  // MARK: Login, logout, and user information
  // =========================================

  func login() {
    guard
      let clientInfo = plistValues(bundle: Bundle.main)
    else {
      return
    }
    
    Auth0
      .webAuth()
      .scope("openid profile email read:current_user update:current_user_metadata")
      .audience("https://\(clientInfo.domain)/api/v2/")
      .start { result in
          
          switch result {
                  
            case .failure(let error):
              print("Error: Couldn’t retrieve user credentials.\n\(error.localizedDescription)")
              
            case .success(let credentials):
              self.cachedCredentials = credentials
              self.userIsAuthenticated = true
              self.userIsNewlyAuthenticated = true
              self.printTokens()
              
              self.getUserInfo()
            
              DispatchQueue.main.async {
                self.updateTitle()
                self.updateButtonsAndStack()
              }
              
          } // switch
          
      } // start()
  }
  
  func getUserInfo() {
    guard
      let accessToken = cachedCredentials?.accessToken
    else {
      return
    }

    Auth0
      .authentication()
      .userInfo(withAccessToken: accessToken)
      .start { result in
       
        switch result {
            
          case .failure(let error):
            print("Error: Couldn’t retrieve user info.\n\(error.localizedDescription)")
          
          case .success(let userInfo):
            self.cachedUserInfo = userInfo
            
            self.getMetadata()
            
            DispatchQueue.main.async {
              self.updateNameAndEmailUI()
            }
            
        } // switch
            
      } // start()
  }
  
  func getMetadata() {
    guard
      let accessToken = cachedCredentials?.accessToken,
      let userInfo = cachedUserInfo
    else {
      return
    }
    
    Auth0
      .users(token: accessToken)
      .get(userInfo.sub, fields: ["user_metadata", "app_metadata"], include: true)
      .start { result in
        
        switch result {
        
          case .failure(let error):
            print("Error: Couldn’t retrieve metadata.\n\(error.localizedDescription)")
          
          case .success(let user):
            let userMetadata = user["user_metadata"] as? [String: Any]
            self.cachedUserMetadata = userMetadata
          
            let appMetadata = user["app_metadata"] as? [String: Any]
            self.cachedAppMetadata = appMetadata
            
            DispatchQueue.main.async {
              self.updateFavoriteColorUI()
                          
              if self.userIsNewlyAuthenticated {
                self.showOptionalAnnouncement()
                self.userIsNewlyAuthenticated = false
              }
            }
            
        } // switch
        
      } // start()
  }

  func updateFavoriteColor() {
    guard
      let accessToken = cachedCredentials?.accessToken,
      let userInfo = cachedUserInfo
    else {
      return
    }
    
    let updatedFavoriteColor = favoriteColorTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    
    Auth0
      .users(token: accessToken)
      .patch(userInfo.sub, userMetadata: ["favorite_color": updatedFavoriteColor ?? ""])
      .start { result in
        
        switch result {
          
          case .failure(let error):
            print("Error: Couldn’t update 'favorite_color' in the user metadata.\n\(error.localizedDescription)")
          
          case .success(let updatedUserMetadata):
            self.cachedUserMetadata = updatedUserMetadata
          
          } // switch
          
        } // start()
  }
  
  func logout() {
    Auth0
      .webAuth()
      .clearSession(federated: false) { result in
        
          if result {
            print("Session cleared!")
            self.userIsAuthenticated = false
            self.cachedCredentials = nil
            self.cachedUserInfo = nil
            self.cachedUserMetadata = nil
            self.cachedAppMetadata = nil
            
            DispatchQueue.main.async {
              self.updateTitle()
              self.updateButtonsAndStack()
            }
          } else {
            print("Session NOT cleared -- time to start debugging.")
          }
        
      } // clearSession()
  }

  func printTokens() {
    if let credentials = cachedCredentials {
      print("\nTOKENS\n======")
      print("ID token: \(credentials.idToken ?? "[No ID token found.]")")
      print("Access token: \(credentials.accessToken ?? "[No access token found.]")")
    }
  }
  
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
