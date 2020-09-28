//
//  FunctionalKeyPaths.swift
//  Utils
//
//  Created by Christian Slanzi on 15.09.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

// a functional keypath called prop

// if you give this function a keypath, you get back a composable setter
// then if you give the composable setter a way to transform the value
// you get back a way to transform the root

public func prop<Root, Value>(_ kp: WritableKeyPath<Root, Value>)
    -> (@escaping (Value) -> Value)
    -> (Root) -> Root {
        
        return { update in
            { root in
                var copy = root
                copy[keyPath: kp] = update(copy[keyPath: kp])
                return copy
            }
        }
}

// overload of prop that curryies the function
public func prop<Root, Value>(
    _ kp: WritableKeyPath<Root, Value>,
    _ f: @escaping (Value) -> Value
) -> (Root) -> Root {
    return prop(kp)(f)
}

// overload of prop that inject the value
public func prop<Root, Value>(
    _ kp: WritableKeyPath<Root, Value>,
    _ value: Value
) -> (Root) -> Root {
    return prop(kp, { _ in value})
}



// but we could have an helper instead of a overload.
public func over<Root, Value>(
    _ setter: (@escaping (Value) -> Value) -> (Root) -> Root,
    _ f: @escaping (Value) -> Value
) -> (Root) -> Root {
    return setter(f)
}

public func set<Root, Value>(
    _ setter: (@escaping (Value) -> Value) -> (Root) -> Root,
    _ value: Value
) -> (Root) -> Root {
    return over(setter, { _ in value })
}

prefix operator ^
public prefix func ^ <Root, Value>(_ kp: WritableKeyPath<Root, Value>)
    -> (@escaping (Value) -> Value)
    -> (Root) -> Root {
        
        return prop(kp) //delegate to prop func
}

// generalize over and set for tuples

public typealias Setter<S, T, A, B> = (@escaping (A) -> B) -> (S) -> T
// S = Source, T = Target, A = first part, B = second part
public func over<S, T, A, B>(
    _ setter: Setter<S, T, A, B>,
    _ f: @escaping (A) -> B
) -> (S) -> T {
    return setter(f)
}

public func set<S, T, A, B>(
    _ setter: Setter<S, T, A, B>,
    _ value: B
) -> (S) -> T {
    return over(setter, { _ in value })
}

// let's have mutable setters for performance

public typealias MutableSetter<S, A> = (@escaping (inout A) -> Void) -> (inout S) -> Void
// S = Source, T = Target, A = first part, B = second part
public func mver<S, A>(
    _ setter: MutableSetter<S, A>,
    _ f: @escaping (inout A) -> Void
) -> (inout S) -> Void {
    return setter(f)
}

public func mut<S, A>(
    _ setter: MutableSetter<S, A>,
    _ value: A
) -> (inout S) -> Void {
    return mver(setter, { $0 = value })
}

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
 */
