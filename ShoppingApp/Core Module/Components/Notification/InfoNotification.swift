//
//  SwiftyInfoNotification.swift
//  CustomViews
//
//  Created by Christian Slanzi on 22.02.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

public class InfoNotification: NSObject {
    var date: Date!
    var headline: String!
    var message: String!
    var isRemotePushNotification = 0
    
    override init() {
        super.init()
        self.date = Date()
    }
}
