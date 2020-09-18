//
//  GettersKeyPaths.swift
//  Utils
//
//  Created by Christian Slanzi on 18.09.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

public func get<Root, Value>(_ kp: KeyPath<Root, Value>) -> (Root) -> Value {
    return { root in
        root[keyPath: kp]
    }
}

fileprivate struct User {
    var id: Int
    var email: String
}

extension User {
    var isStaff: Bool {
        return self.email.hasSuffix("@pointfree.co")
    }
}

private func testGetKeyPaths() {
    let user = User(id: 1, email: "blob@pointfree.co")
    
    let idString = get(\User.id) >>> String.init
    print(user |> idString)
    
    let isStaff = get(\User.isStaff)
    
    let users = [
        User(id: 1, email: "blob@pointfree.co"),
        User(id: 2, email: "protocol@example.co"),
        User(id: 3, email: "bee@domain.co"),
        User(id: 4, email: "a.morphism@category.theory")
    ]
    
    // get all emails
    users.map(get(\.email))
    
    // filter who is staff
    users.filter(get(\.isStaff))
    
    // get the email lenght of each user
    users.map(get(\.email.count))
    
    // filter who is not staff
    users.filter((!) <<< get(\.isStaff))
}
