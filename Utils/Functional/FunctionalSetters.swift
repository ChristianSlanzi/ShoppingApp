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
