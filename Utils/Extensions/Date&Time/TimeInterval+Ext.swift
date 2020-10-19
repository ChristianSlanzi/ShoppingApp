//
//  TimeInterval+Ext.swift
//  Utils
//
//  Created by Christian Slanzi on 13.10.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

public extension TimeInterval {
    func toString() -> String {
        let time = NSInteger(self)

        //let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)

        //return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
        return String(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds)
    }
}
