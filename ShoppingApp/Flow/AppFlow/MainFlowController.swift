//
//  MainFlowController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 07.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

protocol MainFlowControllerDelegate: AnyObject {
    
}

final class MainFlowController: UIViewController, FlowProtocol {
    
    private let tabController = UITabBarController()
    
    func start() {
        tabController.viewControllers = [startProductFlow(),
                                         startShoppingCartFlow()]
        add(childController: tabController)
    }
    
    private func startProductFlow() -> UIViewController {
        let productFlowController = ProductFlowController()
        productFlowController.tabBarItem = UITabBarItem(title: "Shop", image: UIImage(named: "icons-shop"), tag: 0)
        productFlowController.start()
        return productFlowController
    }
    
    private func startShoppingCartFlow() -> UIViewController {
        let shoppingCartFlowController = ShoppingCartFlowController()
        shoppingCartFlowController.tabBarItem =
            UITabBarItem(title: "Cart", image: UIImage(named: "icons-cart"), tag: 1)
        shoppingCartFlowController.start()
        return shoppingCartFlowController
    }
    
}

extension MainFlowController: MainFlowControllerDelegate {
    
}
