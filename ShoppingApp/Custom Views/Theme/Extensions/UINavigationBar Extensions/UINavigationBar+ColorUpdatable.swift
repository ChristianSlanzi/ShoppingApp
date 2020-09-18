//
//  UINavigationBar+ColorUpdatable.swift
//  Fitness-Notiz
//
//  Created by Christian Slanzi on 29.12.19.
//  Copyright © 2019 Christian Slanzi. All rights reserved.
//

import UIKit

public extension UINavigationBar {

    // MARK: - ColorUpdatable

    func updateColors(for theme: Theme) {
        let barStyle: UIBarStyle = {
            switch theme {
            case .light:
                return .default
            case .dark:
                return .blackTranslucent
            default:
                return .default
            }
        }()
        self.barStyle = barStyle
    }
}
