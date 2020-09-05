//
//  FieldValidatable.swift
//  Utils
//
//  Created by Christian Slanzi on 06.05.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

public protocol FieldValidatable {
    var validationRules: [Rule] { get }
    var validationText: String { get }
}
