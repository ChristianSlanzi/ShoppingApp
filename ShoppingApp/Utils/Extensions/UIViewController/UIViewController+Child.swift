//
//  UIViewController+Child.swift
//  Utils
//
//  Created by Christian Slanzi on 06.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

extension UIViewController {
  func add(childController: UIViewController) {
    addChild(childController)
    view.addSubview(childController.view)
    childController.didMove(toParent: self)
  }
 
  func remove(childController: UIViewController) {
    childController.willMove(toParent: nil)
    childController.view.removeFromSuperview()
    childController.removeFromParent()
  }
}
