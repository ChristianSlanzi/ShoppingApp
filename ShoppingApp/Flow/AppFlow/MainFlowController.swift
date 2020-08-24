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
                                         startShoppingCartFlow(),
                                         startOrderCartFlow()]
        add(childController: tabController)
    }
    
    private func startProductFlow() -> UIViewController {
        let productFlowController = ProductFlowController(parent: self)
        productFlowController.tabBarItem = UITabBarItem(title: "tabbar_shop_title".localized, image: UIImage(named: "icons-shop"), tag: 0)
        productFlowController.start()
        return productFlowController
    }
    
    private func startShoppingCartFlow() -> UIViewController {
        let shoppingCartFlowController = ShoppingCartFlowController()
        shoppingCartFlowController.tabBarItem =
            UITabBarItem(title: "tabbar_cart_title".localized, image: UIImage(named: "icons-cart"), tag: 1)
        shoppingCartFlowController.start()
        return shoppingCartFlowController
    }
    
    private func startOrderCartFlow() -> UIViewController {
        let orderFlowController = OrderFlowController(parent: self)
        orderFlowController.tabBarItem =
            UITabBarItem(title: "tabbar_orders_title".localized, image: UIImage(named: "icons-orders"), tag: 2)
        orderFlowController.start()
        return orderFlowController
    }
    
}

extension MainFlowController: MainFlowControllerDelegate {
    
}
