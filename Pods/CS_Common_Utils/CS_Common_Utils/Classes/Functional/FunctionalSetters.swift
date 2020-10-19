//
//  FunctionalSetters.swift
//  Utils
//
//  Created by Christian Slanzi on 15.09.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

// let's work with pairs

// let pair = (42, "Swift")
// (incr(pair.0), pair.1) // not really composable, we need a free-function way

public func first<A, B, C>(_ f: @escaping (A) -> C) -> ((A, B)) -> (C, B) {
    return { pair in
        (f(pair.0), pair.1)
    }
}

// now we can write

// pair
//   |> first(incr)
//   |> first(String.init)

public func second<A, B, C>(_ f: @escaping (B) -> C) -> ((A, B)) -> (A, C) {
    return { pair in
        (pair.0, f(pair.1))
    }
}

// pair
//   |> first(incr)
//   |> first(String.init)
//   |> second { $0 + "!" }

// and allows all sort of composition and mutation

// with nested is going to be a bit messy
// let nested = ((1, true), "Swift")

// nested
//    |> first { $0 |> second { !$0 } }

// this doesn't compile
// nested
//    |> (first >>> second) { !$0 }

// changing the order works
// nested
//    |> (second >>> first) { !$0 }

// but looks strange. we need a backward composing opreator

precedencegroup BackwardsComposition {
    associativity: left
}

infix operator <<< : BackwardsComposition
func <<< <A, B, C>(_ f: @escaping (B) -> C, _ g: @escaping (A) -> B) -> (A) -> C {
    return { f(g($0)) }
}

// now we can write:
// nested
//    |> (first <<< second) { !$0 }

// and compose
fileprivate func incr(_ x: Int) -> Int {
    return x + 1
}

fileprivate func nestedComposition() {
    let nested = ((1, true), "Swift")
    
    let new = nested
        |> (first <<< first)(incr)
        |> (first <<< second) { !$0 }
        |> second { $0 + "!" }
    
    // now we have ((2, false), "Swift!")
    print(new)
}

// and even compose transformations in isolation i.e. we create new functions

/*
private func transformationInIsolation() {
    let nested = ((1, true), "Swift")
    
    let transformation = (first <<< first)(incr)
    <> (first <<< second) { !$0 }
    <> second { $0 + "!" }
    
    // transformation is a function
    
    nested |> transformation
}
*/ // but hard to compile.

