//
//  CustomButton.swift
//  CustomViews
//
//  Created by Christian Slanzi on 22.02.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit
import Utils

/// an app wide custom UIButton utility class
class CustomButton: UIButton {

    private var buttonColor: UIColor = .black
    private var textColor: UIColor = .white
    private var title: String = "Button"
    
    // MARK: - Initializers
    
    override var isEnabled: Bool {
        didSet {
            self.backgroundColor = isEnabled ? buttonColor : .lightGray
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    /// init required by the API to support storyboards
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Configure object specific visual properties of button
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero) // size created by autolayout
        //self.backgroundColor = backgroundColor
        self |> filledRoundedButtonStyle(color: backgroundColor)
        self.setTitle(title, for: .normal)
    }

    // MARK: - Layout Methods

    /// Configure common visual properties of button
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        self |> filledRoundedButtonStyle(color: buttonColor)
        setTitleColor(textColor, for: .normal)
        self.setTitle(title, for: .normal)
    }

    /// Configure button properties from a different class
    func set(backgroundColor: UIColor, title: String) {
        self.buttonColor = backgroundColor
        self |> filledRoundedButtonStyle(color: buttonColor)
        setTitle(title, for: .normal)
    }
    
    func setTitle(_ title: String) {
        setTitle(title, for: .normal)
    }
}
