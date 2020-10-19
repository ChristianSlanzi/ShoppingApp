//
//  UIView+Ext.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 20.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

/// Add an array of subviews to a SuperView
public extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}


// QUICKLY INSTANTIATE AN UIVIEW FROM A NIB / XIB FILE
public extension UIView {
    class func load(nib name: String) -> UIView? {
        return UINib(
            nibName: name,
            bundle: Bundle.main
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}

// EXAMPLE:
private let testview = UIView.load(nib: "CustomButton")


// QUICKLY CREATE A SNAPSHOT OF A UIVIEWCONTROLLER AS A UIIMAGE
public extension UIView {
    func toImageSnapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}


/// Pin edges of View to its SuperView
public extension UIView {
    func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
}

// fitInSuperview
public extension UIView {
    func fitInSuperview() {
       guard let superview = self.superview else { return }
       self.translatesAutoresizingMaskIntoConstraints = false
       topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
       bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
       leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
       rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
    }
    
    func fitInSuperviewMargins() {
       guard let superview = self.superview else { return }
       self.translatesAutoresizingMaskIntoConstraints = false
       topAnchor.constraint(equalTo: superview.topAnchor, constant:
       superview.layoutMargins.top).isActive = true
       bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant:
       -superview.layoutMargins.bottom).isActive = true
       leftAnchor.constraint(equalTo: superview.leftAnchor, constant:
       superview.layoutMargins.left).isActive = true
       rightAnchor.constraint(equalTo: superview.rightAnchor, constant:
       -superview.layoutMargins.right).isActive = true
    }
}
