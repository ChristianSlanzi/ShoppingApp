//
//  UIButton+Ext.swift
//  Utils
//
//  Created by Christian Slanzi on 27.09.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

public extension UIButton {
    var normalBackgroundImage: UIImage? {
        get { return self.backgroundImage(for: .normal)}
        set { self.setBackgroundImage(newValue, for: .normal)}
    }
    var normalTitleColor: UIColor? {
        get { return self.titleColor(for: .normal)}
        set { self.setTitleColor(newValue, for: .normal)}
    }
}
