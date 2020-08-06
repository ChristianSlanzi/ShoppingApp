//
//  AppFlowController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 06.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

import UIKit

//protocol FlowController {
//  var navigationController: UINavigationController {get}
//}

public protocol FlowProtocol {
    func start()
}

class AppFlowController: UIViewController, FlowProtocol {
    
    func start() {
        startWelcomeScreen()
    }
    
    private func startWelcomeScreen() {
        add(childController: ViewController())
    }
}
