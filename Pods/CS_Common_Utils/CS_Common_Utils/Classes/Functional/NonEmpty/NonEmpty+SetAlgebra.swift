//
//  NonEmpty+SetAlgebra.swift
//  Utils
//
//  Created by Christian Slanzi on 04.10.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

public extension NonEmpty where Collection: SetAlgebra {
    init(_ head: Collection.Element, _ tail: Collection) {
        var tail = tail
        tail.remove(head)
        self.head = head
        self.tail = tail
    }
    
    init(_ head: Collection.Element, _ tail: Collection.Element...) {
        var tail = Collection(tail)
        tail.remove(head)
        self.head = head
        self.tail = tail
    }
}

public typealias NonEmptySet<A> = NonEmpty<Set<A>> where A: Hashable

public typealias NonEmptyArray<A> = NonEmpty<[A]>

public func testNonEmptyWithSet() {
    let nonEmptySet = NonEmpty(1, Set([1, 2, 3])) // 1[2, 3]
    nonEmptySet.count // 3
    
    NonEmpty<Set<Int>>(1, 1, 2, 3) // 1[2, 3]
    
    NonEmptySet(1, 1, 2, 3) // 1[2, 3]
}
