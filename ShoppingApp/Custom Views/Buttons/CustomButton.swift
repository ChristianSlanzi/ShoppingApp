//
//  CustomButton.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 21.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

/// an app wide custom UIButton utility class
class CustomButton: UIButton {

    // MARK: - Initializers

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
        self |> filledRoundedButtonStyle(color: .black)
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }

    /// Configure button properties from a different class
    func set(backgroundColor: UIColor, title: String) {
        //self.backgroundColor = backgroundColor
        self |> filledRoundedButtonStyle(color: backgroundColor)
        setTitle(title, for: .normal)
    }
}
