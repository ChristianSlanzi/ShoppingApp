//
//  UITabBar+ColorUpdatable.swift
//  Fitness-Notiz
//
//  Created by Christian Slanzi on 29.12.19.
//  Copyright © 2019 Christian Slanzi. All rights reserved.
//

import UIKit

public extension UITabBar {
    
    // MARK: - ColorUpdatable
    
    func updateColors(for theme: Theme) {
        let barStyle: UIBarStyle = {
            switch theme {
            case .light:
                self.barTintColor = .white
                return .default
            case .dark:
                self.barTintColor = .darkGray
                return .black
            default:
                self.barTintColor = .white
                return .default
            }
        }()
        self.barStyle = barStyle
    }
}
