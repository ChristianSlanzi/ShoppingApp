//
//  Analytics.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 25.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

struct Analytics {
    
    struct Event {
        var name: String
        var properties: [String: String]
        
        static func loadedScreen(screenName: String) -> Event {
            return Event(name: "loaded_screen",
                         properties: [
                            "screen_name": screenName,
                            "build": Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "Unknown",
                            "release": Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown",
                            "screen_height": String(describing: UIScreen.main.bounds.height),
                            "screen_width": String(describing: UIScreen.main.bounds.width),
                            "system_name": UIDevice.current.systemName,
                            "system_version": UIDevice.current.systemVersion
            ])
        }
    }
    
    var track = track(_:)
}

private func track(_ event: Analytics.Event) {
    print("Tracked", event)
}
