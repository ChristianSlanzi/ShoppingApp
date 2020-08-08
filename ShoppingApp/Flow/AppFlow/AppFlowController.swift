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

protocol AppFlowControllerDelegate: AnyObject {
    func welcomeControllerDidFinish(_ flowController: WelcomeViewController)
}

class AppFlowController: UIViewController, FlowProtocol {
    
    func start() {
        startWelcomeScreen()
    }
    
    private func startWelcomeScreen() {
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.flowDelegate = self
        add(childController: welcomeViewController)
    }
    
    private func startMainScreen() {
      let mainFlowController = MainFlowController()
      //mainFlowController.delegate = self
      add(childController: mainFlowController)
      mainFlowController.start()
    }
}

extension AppFlowController: AppFlowControllerDelegate {
  func welcomeControllerDidFinish(_ flowController: WelcomeViewController) {
    remove(childController: flowController)
    startMainScreen()
  }
}
