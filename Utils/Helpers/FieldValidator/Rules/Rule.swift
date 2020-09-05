//
//  Rule.swift
//  Utils
//
//  Created by Christian Slanzi on 06.05.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

public protocol Rule {
    func validate(value: String) -> Bool
    func errorMessage() -> String
}
