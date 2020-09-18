//
//  ColorUpdatable.swift
//  Fitness-Notiz
//
//  Created by Christian Slanzi on 29.12.19.
//  Copyright © 2019 Christian Slanzi. All rights reserved.
//

/// A protocol which denotes types which can update their colors.
public protocol ColorUpdatable {
    
    /// The theme for which to update colors.
    var theme: Theme { get set }
    
    /// A function that is called when colors should be updated.
    ///
    /// - Parameter theme: The theme for which to update colors.
    func updateColors(for theme: Theme)
}
