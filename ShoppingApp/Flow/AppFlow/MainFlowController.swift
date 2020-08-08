//
//  MainFlowController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 07.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

final class MainFlowController: UIViewController, FlowProtocol {
    
    private let tabController = UITabBarController()
    
    func start() {
        tabController.viewControllers = [startProductFlow(),
                                         startShoppingCartFlow()]
        add(childController: tabController)
    }
    
    private func startProductFlow() -> UIViewController {
        let categoriesViewController = CategoriesViewController()
        categoriesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        return categoriesViewController
    }
    
    private func startShoppingCartFlow() -> UIViewController {
        let shoppingCartViewController = ShoppingCartViewController()
        shoppingCartViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        return shoppingCartViewController
    }
    
}
