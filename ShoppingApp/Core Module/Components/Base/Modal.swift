//
//  Modal.swift
//  CustomViews
//
//  Created by Christian Slanzi on 22.02.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

import UIKit

protocol Modal {
    func show(animated: Bool)
    func dismiss(animated: Bool)
    var backgroundView: UIView { get }
    var dialogView: UIView { get set }
}

extension Modal where Self: UIView {
    func show(animated: Bool) {
        self.backgroundView.alpha = 0
        if var topController = UIApplication.shared.delegate?.window??.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.view.addSubview(self)
        }
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 0.66
            })
            UIView.animate(withDuration: 0.33,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 10,
                           options: UIView.AnimationOptions(rawValue: 0),
                           animations: { self.dialogView.center  = self.center },
                           completion: { (completed) in
                            
            })
        } else {
            self.backgroundView.alpha = 0.66
            self.dialogView.center  = self.center
        }
    }
    
    func dismiss(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 0
            }, completion: { _ in
                
            })
            UIView.animate(withDuration: 0.33,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 10,
                           options: UIView.AnimationOptions(rawValue: 0),
                           animations: {
                                self.dialogView.center = CGPoint(x: self.center.x,
                                                                 y: self.frame.height + self.dialogView.frame.height/2)
            }, completion: { _ in
                self.removeFromSuperview()
            })
        } else {
            self.removeFromSuperview()
        }
        
    }
}
