//
//  Bundle+Ext.swift
//  Utils
//
//  Created by Christian Slanzi on 23.09.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

public extension Bundle {
    static var current: Bundle {
        class __ { }
        return Bundle(for: __.self)
    }
}
