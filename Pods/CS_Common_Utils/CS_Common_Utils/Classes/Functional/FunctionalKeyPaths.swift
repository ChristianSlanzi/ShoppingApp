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
/*
public func prop<Root, Value>(_ keyPath: WritableKeyPath<Root, Value>)
    -> (@escaping (Value) -> Value)
    -> (Root) -> Root {
        
        return { update in
            { root in
                var copy = root
                copy[keyPath: keyPath] = update(copy[keyPath: keyPath])
                return copy
            }
        }
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

/// Produces a value-mutable setter function for a given key path and new value.
///
/// - Parameters:
///   - keyPath: A writable key path.
///   - value: A new value.
/// - Returns: A value-mutable setter function.
public func mut<Root, Value>(
  _ keyPath: WritableKeyPath<Root, Value>,
  _ value: Value
  )
  -> (inout Root) -> Void {

    return mver(keyPath) { $0 = value }
}

/// Produces a reference-mutable setter function for a given key path and new value.
///
/// - Parameters:
///   - keyPath: A reference-writable key path.
///   - value: A new value.
/// - Returns: A reference-mutable setter function.
public func mut<Root, Value>(
  _ keyPath: ReferenceWritableKeyPath<Root, Value>,
  _ value: Value
  )
  -> (Root) -> Void {

    return mver(keyPath) { $0 = value }
}



//public prefix func ^ <Root, Value>(_ kp: WritableKeyPath<Root, Value>)
//    -> (@escaping (inout Value) -> Void)
//    -> (inout Root) -> Void {
//    return { update in
//        return { root in
//            update(&root[keyPath: kp])
//        }
//    }
//}



/// Produces an immutable setter function for a given key path and update function.
///
/// - Parameters
///   - keyPath: A key path.
///   - update: An update function.
/// - Returns: A setter function.
public func over<Root, Value>(
  _ keyPath: WritableKeyPath<Root, Value>,
  _ update: @escaping (Value) -> Value
  )
  -> (Root) -> Root {

    return prop(keyPath)(update)
}

/// Produces an immutable setter function for a given key path and constant value.
///
/// - Parameters:
///   - keyPath: A key path.
///   - value: A new value.
/// - Returns: A setter function.
public func set<Root, Value>(
  _ keyPath: WritableKeyPath<Root, Value>,
  _ value: Value
  )
  -> (Root) -> Root {

    return over(keyPath) { _ in value }
}

// MARK: - Mutation

/// Produces an in-place setter function for a given key path. Useful for composing value property changes efficiently.
///
/// - Parameter keyPath: A writable key path.
/// - Returns: A mutable setter function.
public func mprop<Root, Value>(
  _ keyPath: WritableKeyPath<Root, Value>
  )
  -> (@escaping (inout Value) -> Void)
  -> (inout Root) -> Void {

    return { update in
      { root in
        update(&root[keyPath: keyPath])
      }
    }
}

/// Uncurried `mver`. Takes a key path and update function all at once.
///
/// - Parameters:
///   - keyPath: A writable key path.
///   - update: An update function for a given value.
/// - Returns: A value-mutable setter function.
public func mver<Root, Value>(
  _ keyPath: WritableKeyPath<Root, Value>,
  _ update: @escaping (inout Value) -> Void
  )
  -> (inout Root) -> Void {

    return mprop(keyPath)(update)
}

/// Produces a reference-mutable setter function for a given key path to a reference. Useful for composing reference property changes efficiently.
///
/// - Parameter keyPath: A reference-writable key path.
/// - Returns: A reference-mutable setter function.
public func mprop<Root, Value>(
  _ keyPath: ReferenceWritableKeyPath<Root, Value>
  )
  -> (@escaping (Value) -> Void)
  -> (Root) -> Void
  where Value: AnyObject {

    return { update in
      { root in
        update(root[keyPath: keyPath])
      }
    }
}

/// Uncurried `mver`. Takes a key path and update function all at once.
///
/// - Parameters:
///   - keyPath: A reference-writable key path.
///   - update: An update function for a given value.
/// - Returns: A reference-mutable setter function.
public func mverObject<Root, Value>(
  _ keyPath: ReferenceWritableKeyPath<Root, Value>,
  _ update: @escaping (Value) -> Void
  )
  -> (Root) -> Void
  where Value: AnyObject {

    return mprop(keyPath)(update)
}

/// Produces an reference-mutable setter function for a given key path to a value. Useful for composing reference property changes efficiently.
///
/// - Parameter keyPath: A key path.
/// - Returns: A setter function.
public func mprop<Root, Value>(
  _ keyPath: ReferenceWritableKeyPath<Root, Value>
  )
  -> (@escaping (inout Value) -> Void)
  -> (Root) -> Void {

    return { update in
      { root in
        update(&root[keyPath: keyPath])
      }
    }
}

/// Uncurried `mver`. Takes a key path and update function all at once.
///
/// - Parameters:
///   - keyPath: A reference-writable key path.
///   - update: An update function for a given value.
/// - Returns: A reference-mutable setter function.
public func mver<Root, Value>(
  _ keyPath: ReferenceWritableKeyPath<Root, Value>,
  _ update: @escaping (inout Value) -> Void
  )
  -> (Root) -> Void {

    return mprop(keyPath)(update)
}
*/
