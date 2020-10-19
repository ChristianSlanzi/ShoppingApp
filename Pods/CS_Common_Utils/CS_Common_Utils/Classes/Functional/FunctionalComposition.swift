//
//  FunctionalComposition.swift
//  CommonModule
//
//  Created by Christian Slanzi on 31.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

// Pipe-or operator: i.e., 2 |> incr |> square
precedencegroup ForwardApplication {
    associativity: left
}

infix operator |>: ForwardApplication

public func |> <A, B>(a: A, f: (A) -> B) -> B {
    return f(a)
}

func |> <A, B>(a: A, f: (A) throws -> B) throws -> B {
    return try f(a)
}

//forward compose operator
precedencegroup ForwardComposition {
    associativity: left
    //higherThan: ForwardApplication
    higherThan: EffectfulComposition
}

infix operator >>>

public func >>> <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> ((A) -> C) {
    return { a in
        g(f(a))
    }
}

func >>> <A, B, C>(f: @escaping (A) throws -> B, g: @escaping (B) throws -> C) -> ((A) throws -> C) {
    return { a in
        try g(f(a))
    }
}

// 2 |> incr >>> square (first increment, then square)

// Fish operator
precedencegroup EffectfulComposition {
    associativity: left
    higherThan: ForwardApplication
    //lowerThan: ForwardComposition
}

infix operator >=>: EffectfulComposition

public func >=> <A, B, C>(
    _ f: @escaping (A) -> B?,
    _ g: @escaping (B) -> C?
) -> ((A) -> C?) {
    return { a in
        fatalError()
    }
}

// Diamond operator (combine 2 functions on the same type in one function)
precedencegroup SingleTypeComposition {
    associativity: right
    higherThan: ForwardApplication
}

infix operator <> : SingleTypeComposition

public func <> <A: Any>(f: @escaping (A) -> A,
                              g: @escaping (A) -> A) -> (A) -> A {
   return f >>> g
}

public func <> <A: Any>(f: @escaping (A) -> Void, g: @escaping (A) -> Void) -> (A) -> Void {
  return { a in
    f(a)
    g(a)
  }
}

public func <> <A: Any>(f: @escaping (inout A) -> Void,
                              g: @escaping (inout A) -> Void) -> (inout A) -> Void {
   return { a in
    f(&a)
    g(&a)
   }
}


struct CoolOperator {
    let name: String
    let readableName: String
}

let knownOperators = [
    CoolOperator(name: "<>", readableName: "Diamond"),
    CoolOperator(name: "|>", readableName: "Pipe")
]

