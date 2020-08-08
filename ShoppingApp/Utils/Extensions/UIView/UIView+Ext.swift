//
//  UIView+Ext.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 20.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

extension UIView {

    /// Pin edges of View to its SuperView
    func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }

    /// Add an array of subviews to a SuperView
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
