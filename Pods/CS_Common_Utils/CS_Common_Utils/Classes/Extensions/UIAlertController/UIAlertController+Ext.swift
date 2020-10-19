//
//  UIAlertController+Ext.swift
//  Utils
//
//  Created by Christian Slanzi on 13.10.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

public extension UIAlertController {
  static func confirm(_ title: String, callback: @escaping (Bool) -> Void) {
    let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)

    //TODO: Refactor Strings
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
      callback(false)
    }))
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
      callback(true)
    }))

    //TODO: add support for iOS 13 Scene
    let root = UIApplication.shared.keyWindow?.rootViewController
    root?.present(alert, animated: true, completion: nil)
  }
}
