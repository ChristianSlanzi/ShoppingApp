//
//  Contravariance.swift
//  Utils
//
//  Created by Christian Slanzi on 26.09.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

public func wrapView(padding: UIEdgeInsets) -> (UIView) -> UIView {
    return { subview in
        let wrapper = UIView()
        subview.translatesAutoresizingMaskIntoConstraints = false
        wrapper.addSubview(subview)
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor, constant: padding.left),
            subview.rightAnchor.constraint(equalTo: wrapper.rightAnchor, constant: -padding.right),
            subview.topAnchor.constraint(equalTo: wrapper.topAnchor, constant: padding.top),
            subview.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor, constant: -padding.bottom),
        ])
        return wrapper
    }
}

func testWrapView() {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    view.backgroundColor = .darkGray
    
    let padding = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
    
    let wrapper = wrapView(padding: padding)(view)
    wrapper.frame.size = CGSize(width: 300, height: 300)
    wrapper.backgroundColor = .lightGray
    
    
    // contravariance - it works with everything derived from UIView
    // when you have a function you are allowed to inject any subtype of input tyoe
    
    let wrapAnUIView = wrapView(padding: padding) as (UIView) -> UIView
    let wrapAnUIButton = wrapView(padding: padding) as (UIButton) -> UIView
    let wrapAnUISwitch = wrapView(padding: padding) as (UISwitch) -> UIView
    let wrapAnUIStackView = wrapView(padding: padding) as (UIStackView) -> UIView
    
    // covariance
}

///
// test covariance and contravariance
///

// Let's have a wrapper type for a function
struct Func<A, B> {
    let apply: (A) -> B
}

// mapping on the output of a function is covariant
func map<A, B, C>(_ f: @escaping (B) -> C) -> ((Func<A, B>) -> Func<A, C>) {
    return { g in
        Func(apply: g.apply >>> f)
    }
}

// mapping on the input of a function is contravariant
func contramap<A, B, C>(_ f: @escaping (B) -> A) -> ((Func<A, C>) -> Func<B, C>) {
    return { g in
        Func(apply: f >>> g.apply)
    }
}

// Set<A: Hashable, Equatable> // a set cannot contain a duplicate element
fileprivate let xs = Set<Int>([1, 2, 3, 4 , 4, 4, 4]) // this results in {1,2,3,4}

// Predicates

struct PredicateSet<A> {
    let contains: (A) -> Bool
    
    func contramap<B>(_ f: @escaping (B) -> A) -> PredicateSet<B> {
        return PredicateSet<B>.init(contains: f >>> self.contains)
    }
}

// PredicateSet vs Set
func testPredicateSet() {
    
    // a PredicateSet can be infinte
    // a Set can be only finite
    let ys = PredicateSet { [1, 2, 3, 4].contains($0) } // a set that contains only 1,2,3,4
    let allInts = PredicateSet<Int> { _ in true }
    let longStrings = PredicateSet<String> { $0.count > 100 }
    
    // a set can be iterable. a predicate set not.
    xs.forEach { print($0) }
    
    // a set cannot be inverted, a predicate set can do that.
    let allIntsNot1234 = PredicateSet { !ys.contains($0) }
    
    // a set can conforms to hashable and equatable. a predicate set not.
    
    // a set doesn't have map, because is hashable and equatable. the resulting value of mapping a set could be a set of less values than the original, because mapped values could not belong to the set anymore.
    
    // a predicate set can be mapped. or better...
    // a predicate set can be contramapped.
    let evens = PredicateSet { $0 % 2 == 0 }
    let odds = evens.contramap{ $0 + 1 }
    
    odds.contains(3) // true
 
    let isLessThan10 = PredicateSet { $0 < 10 }
    
    struct User {
        let id: Int
        let name: String
    }
    
    let userIdLessThan10 = isLessThan10.contramap(^\User.id)   // a new predicate on User id
    let userNameCountLessThan10 = isLessThan10.contramap(^\User.name.count) //all users with name count less than 10
    let isBlobContained = isLessThan10.contramap(^\User.id).contains(User.init(id: 100, name: "Blob")) // false because id is 100
    let isBlob2Contained = isLessThan10
                            .contramap(^\User.name.count)
                            .contains(User.init(id: 100, name: "Blob")) // true because name less than 10
}


