//
//  SettingsService.swift
//  Fitness-Notiz
//
//  Created by Christian Slanzi on 04.01.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

private let _sharedSettingsService = SettingsService()

////We use a struct that we extend with a protocol, so that we can extend it in other modules
//public struct SettingsKey: RawRepresentable, Equatable, Hashable, Comparable {
//
//    public typealias RawValue = String
//
//    public var rawValue: String
//
//    public static let appTheme  = SettingsKey(rawValue: "appTheme")
//    public static let dark = SettingsKey(rawValue: "dark")
//
//    // MARK: Hashable
//    public init(rawValue: RawValue) {
//        self.rawValue = rawValue
//    }
//
//    public var hashValue: Int {
//        return rawValue.hashValue
//    }
//
//    // MARK: Comparable
//    public static func < (lhs: SettingsKey, rhs: SettingsKey) -> Bool {
//
//        return lhs.rawValue < rhs.rawValue
//    }
//}

open class SettingsService {
    
    // MARK: - SHARED INSTANCE
    open class var shared: SettingsService {
        return _sharedSettingsService
    }
    
    public var appTheme: Theme {
        get {
            return UserDefaults.standard[#function] ?? .light
        }
        set {
            UserDefaults.standard[#function] = newValue
        }
    }
    
    public var activeSystemUrlPath: String {
        get {
            return UserDefaults.standard[#function] ?? "PRODUCTION_SYSTEM_BASEL_URL"
        }
        set {
            UserDefaults.standard[#function] = newValue
            synchronize()
        }
    }
    
    public var isNotificationsEnabled: Bool {
        get {
            return UserDefaults.standard[#function] ?? true
        }
        set {
            UserDefaults.standard[#function] = newValue
        }
    }
    
    public func synchronize() {
        UserDefaults.standard.synchronize()
    }
}
