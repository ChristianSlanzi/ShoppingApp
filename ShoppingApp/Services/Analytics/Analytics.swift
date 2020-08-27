//
//  Analytics.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 25.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

struct Version {
    var build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "Unknown"
    var release = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown"
}

struct Screen {
    var height = String(describing: UIScreen.main.bounds.height)
    var width = String(describing: UIScreen.main.bounds.width)
}

struct Device {
    var systemName = UIDevice.current.systemName
    var systemVersion = UIDevice.current.systemVersion
}

struct Analytics {
    
    struct Event {
        var name: String
        var properties: [String: String]
        
        static func loadedScreen(screenName: String) -> Event {
            return Event(name: "loaded_screen",
                         properties: [
                            "screen_name": screenName,
                            "build": Current.version.build,
                            "release": Current.version.release,
                            "screen_height": Current.screen.height,
                            "screen_width": Current.screen.width,
                            "system_name": Current.device.systemName,
                            "system_version": Current.device.systemVersion
            ])
        }
    }
    
    var track = track(_:)
}

private func track(_ event: Analytics.Event) {
    print("Tracked", event)
}
