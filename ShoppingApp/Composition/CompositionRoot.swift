//
//  CompositionRoot.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 06.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

public protocol Composing { func compose() -> UIViewController }

public final class CompositionRoot: Composing {
    var initialVC: UIViewController?

    public func compose() -> UIViewController {
        //let rootNC = UINavigationController(rootViewController: buildInitialViewController())
        return buildInitialViewController()//rootNC
    }
    
    private func buildInitialViewController() -> UIViewController {
        initialVC = ViewController()
        return initialVC!
    }
    
}
