//
//  FunctionalUIStyling.swift
//  Utils
//
//  Created by Christian Slanzi on 28.09.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

public extension CGFloat {
    static func grid_unit(_ n: Int) -> CGFloat {
        return CGFloat(n) * 4
    }
}

public let generousMargins = mut(\UIView.layoutMargins, .init(top: .grid_unit(6), left: .grid_unit(6), bottom: .grid_unit(6), right: .grid_unit(6)))

public let autoLayoutStyle = mut(\UIView.translatesAutoresizingMaskIntoConstraints, false)

public let verticalStackView = mut(\UIStackView.axis, .vertical)
