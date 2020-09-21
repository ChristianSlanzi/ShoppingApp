//
//  Theme.swift
//  Fitness-Notiz
//
//  Created by Christian Slanzi on 29.12.19.
//  Copyright © 2019 Christian Slanzi. All rights reserved.
//

/// The theme for which to configure the appearance of views.
///
/// - light: A bright theme using primarily light colors.
/// - dark: A dim theme using primarily dark colors.

//public enum Theme: Int { //simple solution but not extendable
//    case light
//    case dark
//}

//We use a struct that we extend with a protocol, so that we can extend it in other modules
public struct Theme: RawRepresentable, Equatable, Hashable, Comparable {

    public typealias RawValue = String

    public var rawValue: String

    public static let light  = Theme(rawValue: "light")
    public static let dark = Theme(rawValue: "dark")

    // MARK: Hashable
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }

    public var hashValue: Int {
        return rawValue.hashValue
    }

    // MARK: Comparable
    public static func < (lhs: Theme, rhs: Theme) -> Bool {

        return lhs.rawValue < rhs.rawValue
    }
}

public protocol ThemeProtocol {

}

extension Theme: ThemeProtocol {

}
