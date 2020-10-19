//
//  GettersKeyPaths.swift
//  Utils
//
//  Created by Christian Slanzi on 18.09.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

public func get<Root, Value>(_ keyPath: KeyPath<Root, Value>) -> (Root) -> Value {
    return { root in
        root[keyPath: keyPath]
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

private let users = [
    User(id: 1, email: "blob@pointfree.co"),
    User(id: 2, email: "protocol@example.co"),
    User(id: 3, email: "bee@domain.co"),
    User(id: 4, email: "a.morphism@category.theory")
]

private func testGetKeyPaths() {
    let user = User(id: 1, email: "blob@pointfree.co")
    
    let idString = get(\User.id) >>> String.init
    print(user |> idString)
    
    let isStaff = get(\User.isStaff)
    
    // get all emails
    users.map(get(\.email))
    
    // filter who is staff
    users.filter(get(\.isStaff))
    
    // get the email lenght of each user
    users.map(get(\.email.count))
    
    // filter who is not staff
    users.filter((!) <<< get(\.isStaff))
    
    //user.sorted(by: (User, User) throws -> Bool)
    
    // sorting by shortest email - lot of noise
    users.sorted(by: { $0.email.count < $1.email.count })
}

// we want a better way to sort by properties

func their<Root, Value>(_ f: @escaping (Root) -> Value, _ g: @escaping (Value, Value) -> Bool) -> (Root, Root) -> Bool {
    return { g(f($0), f($1)) }
}

func testTheir() {
    
    users
        .sorted(by: their(get(\.email), <))
    
    // max and min... but a bit of noise, we have to always give the <
    users
        .max(by: their(get(\.email), <))?.email
    
    users
        .min(by: their(get(\.email), <))?.email
}

// we can have a 'their' for Comparable types

func their<Root, Value: Comparable>(_ f: @escaping (Root) -> Value) -> (Root, Root) -> Bool {
    return their(f, <)
}

func testComparableTheir() {
    users
        .max(by: their(get(\.email)))?.email
    
    users
        .min(by: their(get(\.email)))?.email
}

// REDUCE
// start with a initial value and iterate on each element performing the given operation
// i.e. sum array's values
// [1,2,3]
//   .reduce(0, +)

// what if I want to reduce on a struct?
// I can use a closure.

struct Episode {
    let title: String
    let viewCount: Int
}
let episodes = [
    Episode(title: "Functions", viewCount: 961),
    Episode(title: "Side Effects", viewCount: 841),
    Episode(title: "UIKit Styling with Functions", viewCount: 108),
    Episode(title: "Algebraic Data Types", viewCount: 729)
]

func testReduce() {
    episodes
   .reduce(0) { $0 + $1.viewCount } // short but not clear
}

// we need a combining function
func combining<Root, Value>(
    _ f: @escaping (Root) -> Value,
    by g: @escaping (Value, Value) -> Value) -> (Value, Root) -> Value {
    return { value, root in
        g(value, f(root))
    }
}

func testReduceWithCombining() {
    episodes
        .reduce(0, combining(get(\.viewCount), by: +)) //more readable
}

// Operator overload?

prefix operator ^
public prefix func ^ <Root, Value>(kp: KeyPath<Root, Value>) -> (Root) -> Value {
    return get(kp)
}

fileprivate func testOperatorOverload() {
    let getId = ^\User.id
    users.map(^\.id)
    users.map(^\.email.count)
    users.map(^\.email.count >>> String.init)
    users.filter(^\.isStaff)
    users.filter((!) <<< ^\.isStaff)
    users.sorted(by: their(^\.email))
    users.sorted(by: their(^\.email, >))
    users.max(by: their(^\.email.count))
    users.min(by: their(^\.email.count))
}

func absurd<A>(_ never: Never) -> A {
    switch never {
    
    }
}
