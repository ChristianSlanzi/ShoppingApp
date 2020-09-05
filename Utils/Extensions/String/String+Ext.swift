//
//  String+Ext.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 11.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

// MARK: -  BASE64 CONVERSION
public extension String {
    func toBase64() -> String? {
        let data = self.data(using: String.Encoding.utf8)
        return data?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
}

// MARK: - DATE FROM STRING
public extension String{
    func dateFromDateTimeString() -> Date? {
        return dateFromString(format: "yyyy-MM-dd HH:mm:ss")
    }
    func dateFromString(format: String) -> Date? {
        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.dateFormat = format
        dateTimeFormatter.timeZone = TimeZone.current
        dateTimeFormatter.locale = Locale.current
        return dateTimeFormatter.date(from: self)
    }
}

// MARK: - ACCESS LOCALIZED STRING
public extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
