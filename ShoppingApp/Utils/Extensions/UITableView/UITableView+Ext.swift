//
//  UITableView+Ext.swift
//  Utils
//
//  Created by Christian Slanzi on 21.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

/// extension to remove excess lines on empty cells in UITableView
extension UITableView {

    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}

// not used in this app. Future reference.
extension UITableView {

    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
}
