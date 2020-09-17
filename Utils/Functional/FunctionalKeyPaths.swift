//
//  FunctionalKeyPaths.swift
//  Utils
//
//  Created by Christian Slanzi on 15.09.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

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

// now we can create a functional keypath called prop

// if you give this function a keypath, you get back a composable setter
// then if you give the composable setter a way to transform the value
// you get back a way to transform the root

public func prop<Root, Value>(_ kp: WritableKeyPath<Root, Value>)
    -> (@escaping (Value) -> Value)
    -> (Root)
    -> Root {
        
        return { update in
            { root in
                var copy = root
                copy[keyPath: kp] = update(copy[keyPath: kp])
                return copy
            }
        }
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
