//
//  CGFloat+Grid.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 28.09.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//
import UIKit

extension CGFloat {
    static func grid_unit(_ n: Int) -> CGFloat {
        return CGFloat(n) * 4
    }
}
