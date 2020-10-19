//
//  NSObject+Ext.swift
//  Utils
//
//  Created by Christian Slanzi on 13.10.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import UIKit

// MARK: NSObject
public extension NSObject {
    static func initialize<Type>(value: Type, block: (_ object: Type) -> Void) -> Type {
       block(value)
       return value
    }
}

//Usage:
let titleLabel = UILabel.initialize(value: UILabel()) {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "Hello World"
    $0.textColor = UIColor.blue
}

public extension NSObject {
 
    // SHOW A SIMPLE ALERT MESSAGE FROM ANY VIEWCONTROLLER OR OBJECT
    func showMessage(with title: String, and body: String) {
        if UIApplication.shared.applicationState == .active {
            // IF THE APP IS ACTIVE, IT HAS AN UIVIEWCONTROLLER, LET SHOW USE IT FOR DISPLAYING THE MESSAGE
            if let viewController =  UIApplication.shared.windows.first!.rootViewController {
                let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in })
                viewController.present(alert, animated: true) {}
            }
        } else {
            // ELSE, IF THE APP IS IN BACKGROUND, LET'S TRY TO ISSUE A LOCAL NOTIFICATION
            let localNotification: UILocalNotification = UILocalNotification()
            localNotification.alertAction = title
            localNotification.alertBody = body
            localNotification.fireDate = Date()
            UIApplication.shared.scheduleLocalNotification(localNotification)
        }
    }
    
    // #5: GET THE NEXT AVAILABLE PARENT VIEWCONTROLLER FROM AN OBJECT
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self as? UIResponder
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
