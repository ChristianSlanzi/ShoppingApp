//
//  HighOrderFunctions.swift
//  Utils
//
//  Created by Christian Slanzi on 09.09.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//



/*

// MARK: curry function
// given a function that goes from A,B to C we return a new function
// that goes from A to a function from B to C
public func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in { b in f(a, b) } }
}

// for ex.  func greet(at date: Date, name: String) -> String
// we want  func greet(at date: Date) -> (String) -> String
// so we write curry(greet(at:name))

// we could also use it on String initializer with encoding like that:
// curry(String.init(data:encoding:)) but to pass encoding we have to do:
// curry(String.init(data:encoding:)) >>> { $0(.utf8)}
// because enconding is the second parameter
// it wouuld be better to flip it:

// MARK: flip function
// given a function that goes from A to B to C we return a new function
// that goes from B to A to C
public func flip<A, B, C>(_ f: @escaping (A) -> (B) -> C) -> (B) -> (A) -> C {
    return { b in { a in f(a)(b) } }
}

// but... there's an uppercased overload that takes no argument...
// so flip won't work with it...

// so we can can have also a flip overload

public func flip<A, C>(_ f: @escaping (A) -> () -> C) -> () -> (A) -> C {
    return { { a in f(a)() } }
}

// so now we can write
// "Hello" |> flip(String.uppercased)()

// but we can do something better with zurry
// zurry takes a function with no arguments and just return its evaluation
// it's a curry of zero arguments functions

public func zurry<A>(_ f: () -> A) -> A {
    return f()
}

// and now we can just use it like this
//"Hello" |> zurry(flip(String.uppercased))

// we could also compose swift map functions
// [1,2,3].map(incr).map(square)

// but we can't easily curry them... they have complicated signature, they throw errors..

// but we can define our free-function map overload

public func map<A, B>(_ f: @escaping (A) -> B) -> ([A]) -> ([B]) {
    return { $0.map(f) }
}

// so now we can easiliy compone
// map(incr)
// map(square)
// map(incr) >>> map(square)
// map(incr >>> square)
// map(incr >>> square >>> String.init)

// we can also define a free-function version of filter

public func filter<A>(_ p: @escaping (A) -> Bool) -> ([A]) -> [A] {
    return { $0.filter(p) }
}

// and now use it like this
// filter { $0 > 5 } >>> map(incr >>> square)

*/













import Overture

// now we can write this
public let stringWithEncoding = flip(curry(String.init(data:encoding:)))

// and even combine like this
public let utf8String = stringWithEncoding(.utf8)

// and now use like this
let data = Data(base64Encoded: "some data")!
let encodedString = data |> utf8String  //utf8String(data)

// we can also use all static methods from String like as:

// "Hello".uppercased(with: Locale.init(identifier: "en"))
// that results in
// "HELLO"

public let uppercasedWithLocale = flip(String.uppercased(with:))
public let uppercasedWithEn = uppercasedWithLocale(Locale.init(identifier: "en"))

// so now we can use it like this:
// "Hello" |> uppercasedWithEn










