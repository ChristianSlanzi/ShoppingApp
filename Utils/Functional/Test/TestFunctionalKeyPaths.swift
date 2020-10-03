//
//  TestFunctionalKeyPaths.swift
//  Utils
//
//  Created by Christian Slanzi on 27.09.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

fileprivate struct Food {
    var name: String
}

fileprivate struct Location {
    var name: String
}

fileprivate struct User {
    var favoriteFoods: [Food]
    var location: Location
    var name: String
}

fileprivate func test() {
    let user = User(favoriteFoods: [Food(name: "Tacose"), Food(name: "Nachos")], location: Location(name: "Brooklyn"), name: "Blob")
    
    let usernameKeyPath = \User.name // WriteableKeyPath<User, String>
    
    let username = user[keyPath: \User.name]
    
    var copy = user
    copy[keyPath: \User.name] = "Blobbo"
}

fileprivate func incr(_ x: Int) -> Int {
    return x + 1
}

private func testProp() {
    let user = User(favoriteFoods: [Food(name: "Tacose"), Food(name: "Nachos")], location: Location(name: "Brooklyn"), name: "Blob")
    
    var newUser = user
        |> (prop(\.name)) { $0.uppercased() }
        |> (prop(\.location.name)) { _ in "Los Angeles" }
    
    // we can even compose with map
    
    // classic code would be like that:
    newUser.favoriteFoods = user.favoriteFoods
        .map { Food(name: $0.name + " & Salad") }
    
    // but with prop and functional map:
    let healthier = (prop(\User.favoriteFoods) <<< map <<< prop(\.name)) { $0 + " & Salad"}
    
    user |> healthier
    
    // compose in a free function
    // second(healthier)
    //     <> second(healthier)
    //     <> (second <<< prop(\.location.namee)) { _ in "Miami" }
    //     <> (second <<< prop(\.namee)) { "Healthy" + $0 }
    //     <> first(incr)
    
    // define a date formatter
    
    
}

private let atomDateFormatter = DateFormatter()
    |> (prop(\.dateFormat)) { _ in "yyyy-MM-dd'T'HH:mm:ssZZZZZ" }
    |> (prop(\.locale)) { _ in Locale(identifier: "en_US_POSIX") }
    |> (prop(\.timeZone)) { _ in TimeZone(secondsFromGMT: 0) }

private func testMakeUrlRequest() {
    
    // we define a little helper called guaranteeHeaders that ensure we have at least an empty list of http header fields
    let guaranteeHeaders = (prop(\URLRequest.allHTTPHeaderFields)) { $0 ?? [:] }

    /*
    let postJson =
        guaranteeHeaders
            <> (prop(\URLRequest.httpMethod)) { _ in "POST" }
            <> (prop(\URLRequest.allHTTPHeaderFields) <<< map <<< prop(\.["Content-Type"])) { _ in
                "application/json; charset=utf-8" }
   
    
    let gitHubAccept: [String : String] =
        guaranteeHeaders
            <> (prop(\URLRequest.allHTTPHeaderFields) <<< map <<< prop(\.["Accept"])) { _ in
                "application/vnd.github.v3+json"
    }
     
    let attachAuthorization = { (token: String) in
        guaranteeHeaders
            <>  (prop(\URLRequest.allHTTPHeaderFields) <<< map <<< prop(\.["Authorization"])) { _ in
                           "Token \(token)"
               }
    }
    
    URLRequest(url: URL(string: "https://www.pointfree.com/hello")!)
        |> attachAuthorization("deadbeef")
        |> gitHubAccept
        |> postJson
    
    */
}

extension User {
    static let template = User(favoriteFoods: [Food(name: "Tacos"), Food(name: "Nachos")],
                               location: Location(name: "Brooklyn"),
                               name: "Blob")
}

func testUserDemographyComposition() { // helpful for unit testing
    
    let noFavoriteFoods = (prop(\User.favoriteFoods)) { _ in [] }
    let healthyEater = (prop(\User.favoriteFoods)) { _ in
        [Food(name: "Kale"), Food(name: "Broccoli")]
    }
    let domestic = (prop(\User.location.name)) { _ in "Brooklyn" }
    let international = (prop(\User.location.name)) { _ in "Copenhagen" }
    
    let healthyInternational = User.template
        |> healthyEater
        |> international
    
    let boringLocal = .template
                        |> noFavoriteFoods
                        |> domestic
}

//
private func testSetters() {
    let user = User(favoriteFoods: [Food(name: "Tacose"), Food(name: "Nachos")], location: Location(name: "Brooklyn"), name: "Blob")
    
    user
        |> (prop(\.name)) { $0.uppercased() }  //prop is curryed
        <> (prop(\.location.name)) { _ in "Los Angeles" }
    
    //next can't compile
    //user
    //    |> prop(\.name) { $0.uppercased() }
    //    <> prop(\.location.name) { _ in "Los Angeles" }
    
    //this compiles, we curry the functions. but still not nice.
    user
        |> prop(\.name) ({ $0.uppercased() })
        <> prop(\.location.name) ({ _ in "Los Angeles" })
}

private func testSettersErgonomics() {
    let user = User(favoriteFoods: [Food(name: "Tacose"), Food(name: "Nachos")], location: Location(name: "Brooklyn"), name: "Blob")

    let addCourtesyTitle = { $0 + ", Esq." }
    // now works
    user
        |> prop(\.name, addCourtesyTitle)
        <> prop(\.name) { $0.uppercased() }
        <> prop(\.location.name) { _ in "Los Angeles" }
}

func testPropWithValue() {
    let user = User(favoriteFoods: [Food(name: "Tacose"), Food(name: "Nachos")], location: Location(name: "Brooklyn"), name: "Blob")

    let addCourtesyTitle = { $0 + ", Esq." }
    let healthierOption = { $0 + " & Salad"}
    // now works
    user
        |> prop(\.name, addCourtesyTitle)
        <> prop(\.name) { $0.uppercased() }
        <> prop(\.location.name, "Los Angeles") //now just use setter, value
        //<> (prop(\.favoriteFoods) <<< map <<< prop(\.name)) { $0 + " & Salad" } // mixing the two props overload
        <> (prop(\.favoriteFoods) <<< map <<< prop(\.name))(healthierOption) //better
}

fileprivate func testOverAndSetHelpers() {
    let user = User(favoriteFoods: [Food(name: "Tacose"), Food(name: "Nachos")], location: Location(name: "Brooklyn"), name: "Blob")

    let addCourtesyTitle = { $0 + ", Esq." }
    let healthierOption = { $0 + " & Salad"}

    user
        |> prop(\.name, addCourtesyTitle)
        <> prop(\.name) { $0.uppercased() }
        <> prop(\.location.name, "Los Angeles")
        <> over(prop(\.favoriteFoods) <<< map <<< prop(\.name), healthierOption) //better
    
    //we could use over everywhere
    user
        |> over(prop(\.name), addCourtesyTitle)
        <> over(prop(\.name)) { $0.uppercased() }
        <> set(prop(\.location.name), "Los Angeles")
        <> over(prop(\.favoriteFoods) <<< map <<< prop(\.name), healthierOption) //better
    
    // prop is now getting noisy here... we could cleanup overloading the ^operator
}

fileprivate func testPropOperatorOverload() {
    let user = User(favoriteFoods: [Food(name: "Tacose"), Food(name: "Nachos")], location: Location(name: "Brooklyn"), name: "Blob")

    let addCourtesyTitle = { $0 + ", Esq." }
    let healthierOption = { $0 + " & Salad"}

    user
        |> over(^\.name, addCourtesyTitle)
        <> over(^\.name) { $0.uppercased() }
        <> set(^\.location.name, "Los Angeles")
        <> over(^\.favoriteFoods <<< map <<< ^\.name, healthierOption)
}

fileprivate func testGenericOverAndSet() {
    ("Hello, world", 42)
        |> set(first, [1, 2, 3])
        |> over(second, String.init) //results in ([1, 2, 3], "42")
}

// this requires to change |> and ^
/*
 
 public prefix func ^ <Root, Value>(_ kp: WritableKeyPath<Root, Value>)
     -> (@escaping (inout Value) -> Void)
     -> (inout Root) -> Void {
     return { update in
         return { root in
             update(&root[keyPath: kp])
         }
     }
 }
 
func |> <A>(_ a: A, _ f: (inout A) -> Void) -> A {
    var a = a
    f(&a)
    return a
}
 
fileprivate func testMverAndMut() {
    let user = User(favoriteFoods: [Food(name: "Tacose"), Food(name: "Nachos")], location: Location(name: "Brooklyn"), name: "Blob")
    
    var newUser = user
    newUser
        |> mver(^\.name) { $0 = $0.uppercased() }
        <> mut(^\.location.name, "Los Angeles")
 
    //we can also use setter for array of values
    //but we need a new map function, we call it mutEach
 
    let newUser = user
    |> mver(^\.name) { $0 = $0.uppercased() }
    <> mut(^\.location.name, "Los Angeles")
    <> mver(^\.favoriteFoods <<< mutEach <<< ^\.name) { $0 += " & Salad"}
}
 
func mutEach<A>(_ f: @escaping (inout A) -> Void) -> (inout [A] return {
        for i in $0.indices { f(&$0[i]) }
    }
}
*/
