//
//  UITableView+Ext.swift
//  Utils
//
//  Created by Christian Slanzi on 21.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

public extension IndexPath {
  static fileprivate func fromRow(_ row: Int) -> IndexPath {
    return IndexPath(row: row, section: 0)
  }
}

public extension UITableView {
  func applyChanges(deletions: [Int], insertions: [Int], updates: [Int]) {
    beginUpdates()
    deleteRows(at: deletions.map(IndexPath.fromRow), with: .automatic)
    insertRows(at: insertions.map(IndexPath.fromRow), with: .automatic)
    reloadRows(at: updates.map(IndexPath.fromRow), with: .automatic)
    endUpdates()
  }
}

/// extension to remove excess lines on empty cells in UITableView
public extension UITableView {

    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}

// safe reload
public extension UITableView {

    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
}

public extension UITableView {
    func register(_ type: UITableViewCell.Type) {
        let className = String(describing: type)
        guard Bundle.main.path(forResource: className, ofType: "nib") != nil else {
            register(type, forCellReuseIdentifier: className)
            return
        }
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T>(for type: T.Type) -> T? {
        let className = String(describing: type)
        return dequeueReusableCell(withIdentifier: className) as? T
    }
}
