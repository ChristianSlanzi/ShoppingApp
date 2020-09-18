//
//  ThemeProtocols.swift
//  Fitness-Notiz
//
//  Created by Christian Slanzi on 29.12.19.
//  Copyright © 2019 Christian Slanzi. All rights reserved.
//

import Foundation
import UIKit

//TODO: should we use it as base view controller?

// MARK: Example
class ThemedViewController: UIViewController {
    // MARK: - ColorUpdatable
    
    var theme: Theme = .light {
        didSet {
            guard oldValue != theme else { return }
            updateColors(for: theme)
        }
    }
}

extension ThemedViewController: ColorUpdatable {
    func updateColors(for theme: Theme) {
        view.backgroundColor = .contentBackground(for: theme)
        //childView.updateColors(for: theme)
        // ...
    }
}
