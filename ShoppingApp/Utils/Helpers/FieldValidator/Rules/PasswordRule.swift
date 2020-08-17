//
//  PasswordRule.swift
//  Utils
//
//  Created by Christian Slanzi on 06.05.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

class PasswordRule: Rule {
    
    static let regex = "^.{6,12}$"
    private var message: String
    
    init(message: String = "Must be between 6 and 12 characters") {
        self.message = message
    }
    
    func validate(value: String) -> Bool {
        let pattern = NSPredicate(format: "SELF MATCHES %@", PasswordRule.regex)
        return pattern.evaluate(with: value)
    }
    
    func errorMessage() -> String {
        return message
    }
}
