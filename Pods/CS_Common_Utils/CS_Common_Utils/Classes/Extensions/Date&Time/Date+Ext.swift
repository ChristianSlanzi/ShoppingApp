//
//  Date+Ext.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 24.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

// MARK: - DATE TO STRING
public extension Date {
    func toString(format: String = "MMMM dd yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
public extension Date {
    func toTimeString() -> String {
        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.dateFormat = "HH:mm:ss"
        return dateTimeFormatter.string(from: self)
    }
    func toShortTimeString() -> String {
        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.dateFormat = "HH:mm"
        return dateTimeFormatter.string(from: self)
    }
    func toDayMonthYearString() -> String {
        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.dateFormat = "dd.MM.yyyy"
        return dateTimeFormatter.string(from: self)
    }
    func toDayMonthYearTimeString() -> String {
        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        return dateTimeFormatter.string(from: self)
    }
    func toMonthYearString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"

        return dateFormatter.string(from: self)
    }
}

// MARK: - DATE TO TIMESTAMP
public extension Date {
    func toTimestamp() -> Int64! {
        return Int64(self.timeIntervalSince1970)
    }
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970*1000)
    }
}

// MARK: - DATE-DIFFERENCE TO STRING
public extension Date {
    func toStringOffsetFrom(date: Date) -> String {
        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self)

        let seconds = "\(difference.second ?? 0)s"
        let minutes = "\(difference.minute ?? 0)m" + " " + seconds
        let hours = "\(difference.hour ?? 0)h" + " " + minutes
        let days = "\(difference.day ?? 0)d" + " " + hours

        if let day = difference.day, day          > 0 { return days }
        if let hour = difference.hour, hour       > 0 { return hours }
        if let minute = difference.minute, minute > 0 { return minutes }
        if let second = difference.second, second > 0 { return seconds }
        return ""
    }
}
