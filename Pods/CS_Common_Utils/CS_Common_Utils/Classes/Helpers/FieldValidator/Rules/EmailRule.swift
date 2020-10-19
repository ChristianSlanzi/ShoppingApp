//
//  EmailRule.swift
//  Utils
//
//  Created by Christian Slanzi on 06.05.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

public class EmailRule: Rule {
    
    static let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    private var message: String
    
    public init(message: String = "Invalid Email") {
        self.message = message
    }
    
    public func validate(value: String) -> Bool {
        let pattern = NSPredicate(format: "SELF MATCHES %@", EmailRule.regex)
        return pattern.evaluate(with: value)
    }
    
    public func errorMessage() -> String {
        return message
    }
}
