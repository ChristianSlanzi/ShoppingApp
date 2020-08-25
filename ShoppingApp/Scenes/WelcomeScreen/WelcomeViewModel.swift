//
//  WelcomeViewModel.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 08.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

protocol WelcomeViewModelInputsType {
    func viewDidLoad()
    func didTapStartButton()
}
protocol WelcomeViewModelOutputsType: AnyObject {
    var showMainScreen: (() -> Void) { get set }
}

protocol WelcomeViewModelType {
    var inputs: WelcomeViewModelInputsType { get }
    var outputs: WelcomeViewModelOutputsType { get }
}

final class WelcomeViewModel: WelcomeViewModelType, WelcomeViewModelInputsType, WelcomeViewModelOutputsType {
    
    struct Input {
        //passing in data the viewModel needs from the view controller
    }
    
    struct Output {
        
    }
    
    private var input: Input
    
    init(input: Input) {
        self.input = input
    }
    
    var inputs: WelcomeViewModelInputsType { return self }
    var outputs: WelcomeViewModelOutputsType { return self }
    
    //input
    public func viewDidLoad() {
        Current.analytics.track(.loadedScreen(screenName: "Welcome"))
    }
    
    public func didTapStartButton() {
        showMainScreen()
    }

    //output
    public var showMainScreen: (() -> Void) = { }
    

    
    // MARK: - Helpers
    

}
