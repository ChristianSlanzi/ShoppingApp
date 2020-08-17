//
//  MinimumLenghtRule.swift
//  Utils
//
//  Created by Christian Slanzi on 06.05.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

class MinimumLenghtRule: Rule {
    
    let MIN_LENGTH = 3
    private var message: String
    
    init(message: String) {
        self.message = message
    }
    
    func validate(value: String) -> Bool {
        return value.count > MIN_LENGTH
    }
    
    func errorMessage() -> String {
        return message
    }
}
