//
// UIImageView+Extensions.swift
// iOS UIKit Login
// 3 June 2022
//
// Companion project for the Auth0 blog article
// “Get Started with iOS Authentication Using Swift and UIKit”.
//
// Code from the “Hacking with Swift” article,
// “How to load a remote image URL into UIImageView”
// (https://www.hackingwithswift.com/example-code/uikit/how-to-load-a-remote-image-url-into-uiimageview)
//


import UIKit


extension UIImageView {
  
  func load(url: URL) {
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self?.image = image
          }
        }
      }
    }
  }
  
}
