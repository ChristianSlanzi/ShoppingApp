//
//  UIScrollView+Ext.swift
//  Utils
//
//  Created by Christian Slanzi on 13.10.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

public extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
   }
}
