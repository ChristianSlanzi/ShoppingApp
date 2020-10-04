//
//  NonEmpty.swift
//  Utils
//
//  Created by Christian Slanzi on 04.10.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

public struct NonEmpty<Collection: Swift.Collection>: Swift.Collection {
    var head: Collection.Element
    var tail: Collection
    
    init(_ head: Collection.Element, _ tail: Collection) {
        self.head = head
        self.tail = tail
    }
}

extension NonEmpty: CustomStringConvertible {
    public var description: String {
        return "\(self.head)\(self.tail)"
    }
}

extension NonEmpty where Collection: RangeReplaceableCollection {
    init(_ head: Collection.Element, _ tail: Collection.Element...) {
        self.head = head
        self.tail = Collection(tail)
    }
}

extension NonEmpty {
    
    public enum Index: Comparable {
        
        case head
        case tail(Collection.Index)
        
        public static func < (lhs: NonEmpty<Collection>.Index, rhs: NonEmpty<Collection>.Index) -> Bool {
            switch (lhs, rhs) {
            case (.head, .tail):
                return true
            case (.tail, .head):
                return false
            case (.head, .head):
                return false
            case let (.tail(l), .tail(r)):
                return l < r
            }
        }
    }
    
    public var startIndex: Index {
        return .head
    }
    
    public var endIndex: Index {
        return .tail(self.tail.endIndex)
    }
    
    public subscript(position: Index) -> Collection.Element {
        switch position {
        case .head:
            return self.head
        case let .tail(index):
            return self.tail[index]
        }
    }
    
    public func index(after i: Index) -> Index {
        switch i {
        case .head:
            return .tail(self.tail.startIndex)
        case let .tail(index):
            return .tail(self.tail.index(after: index))
        }
    }
    
    var first: Collection.Element {
        return self.head
    }
}

extension NonEmpty: BidirectionalCollection where Collection: BidirectionalCollection {
    public func index(before i: Index) -> Index {
        switch i {
        case .head:
            return self.tail.index(before: self.tail.startIndex) as! NonEmpty<Collection>.Index
        case let .tail(index):
            return index == self.tail.startIndex ? .head
                : .tail(self.tail.index(before: index))
        }
    }
}

extension NonEmpty where Collection: BidirectionalCollection {
    var last: Collection.Element {
        return self.tail.last ?? self.head
    }
}

extension NonEmpty where Collection.Index == Int {
    subscript(position: Int) -> Collection.Element {
        return self[position == 0 ? .head : .tail(position - 1)]
    }
}

extension NonEmpty: MutableCollection where Collection: MutableCollection { public subscript(position: Index) -> Collection.Element {
    get {
        switch position { case .head:
            return self.head case let .tail(index):
                return self.tail[index] }
    }
    set(newValue) {
        switch position { case .head:
            self.head = newValue case let .tail(index):
                self.tail[index] = newValue }
    } }
}

private func testNonEmpty() {
    
    NonEmpty<[Int]>(1, [2, 3])
    NonEmpty<[Int]>(1, [])
    NonEmpty<Set<Int>>(1, [2, 3])
    NonEmpty<[Int: String]>((1, "Blob"), [2: "Blob Junior", 3: "Blob Senior"])
    
    //RangeReplaceableCollection
    NonEmpty<[Int]>(1, 2, 3)
    
    let ys = NonEmpty<[Int]>(1, 2, 3)
    ys.forEach { print($0) }
    
    ys.first + 1
    ys.last + 1
}

