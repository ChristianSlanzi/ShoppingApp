//
//  FlatMaps.swift
//  Utils
//
//  Created by Christian Slanzi on 24.09.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

// there was once a flat map so defined:

//extension Array {
//    func flatMap<B>(_ f: @escaping (Element) -> [B]) -> [B] {
//        return []
//    }
//}

private func testFlatMap() {
    let csv = """
    1,2,3,4
    3,5,2
    8,9,4
    """
    
    csv
        .split(separator: "\n")
        .map { $0.split(separator: ",") } // returns an array of arrays
    
    csv
        .split(separator: "\n")
        .flatMap { $0.split(separator: ",") } // returns a flattened array with all elements.
}

// we can flatMap an optional - useful for chaining along operations that can return an optional

// extension Optional {
//    func flatMap<B>(_ f: @escaping (Wrapped) -> B?) -> B? {
//
//    }
// }

// for example:

func testFlatMapOptionals() {
    let _: Int?? = String.init(data: Data(), encoding: .utf8) //this returns an Optional String
        .flatMap(Int.init) // we could map into Int ... but this doesnt return an Int? but an Int?? - an optional optional Int
    
    let _: Int? = String.init(data: Data([55]), encoding: .utf8)
        .flatMap(Int.init) // now it returns an Optional Int because we had some data to flatten.
    
    ["1", "2", "buckle", "my", "shoe"]
        .map(Int.init)    // returns [1,2,nil,nil,nil]
    
    ["1", "2", "buckle", "my", "shoe"]
        .flatMap(Int.init)    // returns [1,2]
    
    // so we have flatmap with 2 different behaviours.
    
    // for example:
    let csv = """
    1,2,3,4
    3,5,2
    8,9,4
    """
    
    csv
        .split(separator: "\n") // returns an array of strings
        .flatMap { $0.split(separator: ",") } // returns a flattened array of strings
        .flatMap { Int($0) } // returns an array with only the elements that get converted into integer
        .reduce(0, +) // returns the sum
    
    // the 2 flatmaps above behave differently
    
}

// we have a flatMap that filters out nil elements. this could be implemented in this way:

extension Array {
    func filterMap<B>(_ transform: (Element) -> B?) -> [B] { // this is exactly the 'compactMap' operation
        var result = [B]()
        for x in self {
            switch transform(x) {
            case let .some(x):
                result.append(x)
            case .none:
                continue
            }
        }
        return result
    }
}
