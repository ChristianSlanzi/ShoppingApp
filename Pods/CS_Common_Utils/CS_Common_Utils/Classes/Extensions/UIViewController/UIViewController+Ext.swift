//
//  UIViewController+Ext.swift
//  Utils
//
//  Created by Christian Slanzi on 21.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit
import SafariServices

public extension UIViewController {

    /// Creates and presents a custom alert on the main thread
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            //let alertVC = AlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
            //alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve
            self.present(alert, animated: true)
        }
    }

    /// present SafariViewController
    func presentSafariViewController(with url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredControlTintColor = .systemGreen
        present(safariViewController, animated: true)
    }

}
