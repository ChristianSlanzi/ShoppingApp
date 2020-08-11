//
//  String+Ext.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 11.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

// DATE FROM STRING
extension String{
    func dateFromString() -> Date? {
        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateTimeFormatter.date(from: self)
    }
}

extension String {
    // ACCESS LOCALIZED STRING
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
