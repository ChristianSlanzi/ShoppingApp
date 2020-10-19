//
//  UIStackView+Ext.swift
//  Utils
//
//  Created by Christian Slanzi on 13.10.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

public extension UIStackView {
  func setupStandardVertical() {
     self.translatesAutoresizingMaskIntoConstraints = false
     self.distribution = .fill
     self.axis = .vertical
     self.alignment = .fill
  }
  func setupStandardHorizontal() {
     self.translatesAutoresizingMaskIntoConstraints = false
     self.distribution = .fill
     self.axis = .horizontal
     self.alignment = .fill
  }
}
