//
//  RequiredRule.swift
//  Utils
//
//  Created by Christian Slanzi on 06.05.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

open class RequiredRule: Rule {
    
    private var message: String
    
    init(message: String = "Required") {
        self.message = message
    }
    
    func validate(value: String) -> Bool {
        return !value.isEmpty
    }
    
    func errorMessage() -> String {
        return message
    }
}
