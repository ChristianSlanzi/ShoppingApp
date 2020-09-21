//
//  UILabel+ColorUpdatable.swift
//  Fitness-Notiz
//
//  Created by Christian Slanzi on 13.01.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import UIKit

public extension UILabel {
    
    // MARK: - ColorUpdatable
    
    func configureBackgroundColor(for theme: Theme) {
        backgroundColor = .contentBackground(for: theme)
    }
}
