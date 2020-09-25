//
//  Tagged.swift
//  Utils
//
//  Created by Christian Slanzi on 25.09.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

struct Tagged<Tag, RawValue> {
    let rawValue: RawValue
}

// conform to Decodable so we can tag json types.
extension Tagged: Decodable where RawValue: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(rawValue: try container.decode(RawValue.self))
    }
}

// conform to Equatable so we can compate our tagged types
extension Tagged: Equatable where RawValue: Equatable {
    static func == (lhs: Tagged<Tag, RawValue>, rhs: Tagged<Tag, RawValue>) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

// conform to ExpressibleByIntegerLiteral, so you can direct initialize a Tagged Int type with a int value
extension Tagged: ExpressibleByIntegerLiteral where RawValue: ExpressibleByIntegerLiteral {
    
    typealias IntegerLiteralType = RawValue.IntegerLiteralType
    
    init(integerLiteral value: RawValue.IntegerLiteralType) {
        self.init(rawValue: RawValue(integerLiteral: value))
    }
}

// conform to ExpressibleByStringLiteral, so you can direct initialize a Tagged String type with a int value
extension Tagged: ExpressibleByStringLiteral where RawValue: ExpressibleByStringLiteral {
     
    typealias StringLiteralType = RawValue.StringLiteralType
    
    init(stringLiteral value: RawValue.StringLiteralType) {
        self.init(rawValue: RawValue(stringLiteral: value))
    }
}

extension Tagged: ExpressibleByUnicodeScalarLiteral where RawValue: ExpressibleByUnicodeScalarLiteral {
    init(unicodeScalarLiteral value: RawValue.UnicodeScalarLiteralType) {
        self.init(rawValue: RawValue(unicodeScalarLiteral: value))
    }
    
    typealias UnicodeScalarLiteralType = RawValue.UnicodeScalarLiteralType
}

extension Tagged: ExpressibleByExtendedGraphemeClusterLiteral where RawValue: ExpressibleByExtendedGraphemeClusterLiteral {
    init(extendedGraphemeClusterLiteral value: RawValue.ExtendedGraphemeClusterLiteralType) {
        self.init(rawValue: RawValue(extendedGraphemeClusterLiteral: value))
    }
    
    typealias ExtendedGraphemeClusterLiteralType = RawValue.ExtendedGraphemeClusterLiteralType
}



// Example:

fileprivate func testTagged() {
    
    let usersJson = """
    [
        {
            "id": 1,
            "name": "Brandon",
            "email": "brandon@pointfree.co", "subscriptionId": 1
        },
        {
            "id": 2,
            "name": "Stephen",
            "email": "stephen@pointfree.co", "subscriptionId": null
        },
        {
            "id": 3,
            "name": "Blob",
            "email": "blob@pointfree.co", "subscriptionId": 1
        }
    ]
    """
    
    let subscriptionsJson = """
    [
        {
            "id": 1,
            "ownerId": 1
        }
    ]
    """
    
    let decoder = JSONDecoder()
    
    var users: [User] = []
    
    do {
        users = try decoder.decode([User].self, from: Data(usersJson.utf8))
    } catch let error {
        print("decoding usersJson failed with error \(error.localizedDescription)")
    }
    print(users)
    
    var subscriptions: [Subscription] = []
    
    do {
        subscriptions = try decoder.decode([Subscription].self, from: Data(subscriptionsJson.utf8))
    } catch let error {
        print("decoding subscriptionsJson failed with error \(error.localizedDescription)")
    }
    print(subscriptions)
    
    let user = users[0]
    sendEmail(email: user.email)

    // works
    let subscription = subscriptions.first(where: { $0.id == user.subscriptionId })
    
    // doesn't works - Subscription.Id and User.Id are now two different types, even if they are both Int
    // let subscription2 = subscriptions .first(where: { $0.id == user.id })
}

/*
fileprivate struct Subscription: Decodable {
    let id: Int
    let ownerId: Int
}

fileprivate struct User: Decodable {
    let id: Int
    let name: String
    let email: String
    let subscriptionId: Int?
}
 
func sendEmail(email: String) {
     //
}
*/

// we want better types definition
/*
fileprivate struct Email: Decodable, RawRepresentable {
    let rawValue: String
}

fileprivate struct User: Decodable {
 let id: Int
 let name: String
 let email: Email
 let subscriptionId: Int?
}

fileprivate struct Subscription: Decodable {
    let id: Int
    let ownerId: Int
}
 */

 func sendEmail(email: Email) {
      //
 }


// good, but we still want better types definition, so  types-checkin is preventing us to write wrong code
// for example using or comparing subscriptionId and ownerId like they are the same.

/*
fileprivate struct Email: Decodable, RawRepresentable {
    let rawValue: String
}

fileprivate struct User: Decodable {
    struct Id: Decodable, RawRepresentable, Equatable { let rawValue: Int }
    
    let id: User.Id
    let name: String
    let email: Email
    let subscriptionId: Subscription.Id?
}

fileprivate struct Subscription: Decodable {
    struct Id: Decodable, RawRepresentable, Equatable { let rawValue: Int }
    
    let id: Id
    let ownerId: Int
}
*/

// but a bit noisy... we can simplify using Tagged

fileprivate struct User: Decodable {
    typealias Id = Tagged<User, Int>
    
    let id: Id
    let name: String
    let email: Email
    let subscriptionId: Subscription.Id?
}

fileprivate struct Subscription: Decodable {
    typealias Id = Tagged<Subscription, Int>
    
    let id: Id
    let ownerId: User.Id
}

// what about email? we can do the same, using a phantom type
enum EmailTag {}
typealias Email = Tagged<EmailTag, String>
