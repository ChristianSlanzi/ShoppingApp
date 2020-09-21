//
//  CustomNotification.swift
//  Fitness-Notiz
//
//  Created by Christian Slanzi on 29.12.19.
//  Copyright © 2019 Christian Slanzi. All rights reserved.
//

import Foundation

/// Custom notifications for which to broadcast important messages throughout the app.
///
/// - didChangeColorTheme: A notification indicating that the app's color theme has changed.
public enum CustomNotification: String {
    
    case didChangeColorTheme
    
    /// Broadcasts a global notification.
    ///
    /// - Parameters:
    ///   - notificationCenter: The mechanism for broadcasting information throughout the app.
    ///   - object: The object posting the notification.
    ///   - userInfo: Information about the the notification.
    public func post(notificationCenter: NotificationCenter = NotificationCenter.default, object: AnyObject? = nil, userInfo: Any) {
        let userInfo = [self.rawValue: userInfo]
        DispatchQueue.main.async {
            notificationCenter.post(name: Notification.Name(rawValue: self.rawValue), object: object, userInfo: userInfo)
        }
    }
    
    /// Observes a global notification using a provided method.
    ///
    /// - Parameters:
    ///   - notificationCenter: The mechanism for broadcasting information throughout the app.
    ///   - target: The object on which to call the `selector` method.
    ///   - selector: The method to call when the notification is broadcast.
    func observe(notificationCenter: NotificationCenter = NotificationCenter.default, target: AnyObject, selector: Selector) {
        notificationCenter.addObserver(target, selector: selector, name: Notification.Name(rawValue: self.rawValue), object: nil)
    }
}
