//
//  Date+ISO8601.swift
//  Utils
//
//  Created by Christian Slanzi on 13.10.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

public extension Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}

public extension Date {
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
}
