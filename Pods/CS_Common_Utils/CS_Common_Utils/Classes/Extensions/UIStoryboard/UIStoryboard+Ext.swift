//
//  UIStoryboard+Extr.swift
//  Utils
//
//  Created by Christian Slanzi on 13.10.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

public extension UIStoryboard {
  func instantiateViewController<T: AnyObject>(_ type: T.Type) -> T {
    return instantiateViewController(withIdentifier: String(describing: type)) as! T
  }
}
