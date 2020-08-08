//
//  WelcomeViewController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 06.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    var flowDelegate: AppFlowControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemPink
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.flowDelegate?.welcomeControllerDidFinish(self)
        }
    }
}
