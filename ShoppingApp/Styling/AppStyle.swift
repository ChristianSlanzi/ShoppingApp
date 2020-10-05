//
//  AppStyle.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 30.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit
import Utils
import Overture

// PALETTE

// buttons
let primaryButtonColor: UIColor = .systemGreen
let primaryTextButtonColor: UIColor? = .white

let secondaryButtonColor: UIColor = .systemYellow
let secondaryTextButtonColor: UIColor? = .white

// labels
let primaryTextLabelColor: UIColor? = .black














// NEW WAY using Overture

public extension CGFloat {
    static func grid_unit(_ n: Int) -> CGFloat {
        return CGFloat(n) * 4
    }
}

public let generousMargins = mut(\UIView.layoutMargins, .init(top: .grid_unit(6), left: .grid_unit(6), bottom: .grid_unit(6), right: .grid_unit(6)))

public let autoLayoutStyle = mut(\UIView.translatesAutoresizingMaskIntoConstraints, false)

public let verticalStackView = mut(\UIStackView.axis, .vertical)

public let baseStackViewStyle = concat(
    generousMargins,
    verticalStackView,
    mut(\.isLayoutMarginsRelativeArrangement, true),
    autoLayoutStyle
)

public let bolded: (inout UIFont) -> Void = { $0 = $0.bolded }

public let baseTextButtonStyle = concat(
    mut(\UIButton.titleLabel!.font, UIFont.preferredFont(forTextStyle: .subheadline)),
    mver(\UIButton.titleLabel!.font!, bolded)
)

public let secondaryTextButtonStyle = concat(
    baseTextButtonStyle,
    mut(\.normalTitleColor, secondaryTextButtonColor)
)

public let primaryTextButtonStyle = concat(
    baseTextButtonStyle,
    mut(\.normalTitleColor, primaryTextButtonColor)
)

public let baseButtonStyle = concat(
    baseTextButtonStyle,
    mut(\.contentEdgeInsets, .init(top: .grid_unit(2), left: .grid_unit(4), bottom: .grid_unit(2), right: .grid_unit(4)))
)

//let roundedButtonStyle =
//  baseButtonStyle
//    <> roundedStyle

let roundedButtonStyle = concat(
    baseButtonStyle,
    roundedStyle
)

//let filledButtonStyle =
//  roundedButtonStyle
//  <> filledStyle(color: .black)

func filledButtonStyle(color: UIColor) -> (UIButton) -> Void {
    return {
      $0.backgroundColor = color
    }
}

let filledButtonStyle = concat(
    baseButtonStyle, {
        $0.backgroundColor = .black
        $0.tintColor = .white
    }
)

public func roundedStyle(cornerRadius: CGFloat) -> (UIView) -> Void {
    return concat(
        mut(\.layer.cornerRadius, cornerRadius),
        mut(\.layer.masksToBounds, true)
    )
}

let baseRoundedStyle = roundedStyle(cornerRadius: 10)

let baseFilledButtonStyle = concat(
    baseButtonStyle,
    baseRoundedStyle
)

let primaryButtonStyle = concat(
    baseFilledButtonStyle,
    primaryTextButtonStyle,
    mut(\.normalBackgroundImage, .from(color: primaryButtonColor))
)

let secondaryButtonStyle = concat(
    baseFilledButtonStyle,
    secondaryTextButtonStyle,
    mut(\.normalBackgroundImage, .from(color: secondaryButtonColor))
)

let smallCapsLabelStyle = mut(\UILabel.font, UIFont.preferredFont(forTextStyle: .headline).smallCaps)

// OLD WAY

func baseButtonStyle(_ button: UIButton) {
    //button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
}

func borderStyle(color: UIColor, width: CGFloat) -> (UIView) -> Void {
  return {
    $0.layer.borderColor = color.cgColor
    $0.layer.borderWidth = width
  }
}

func filledStyle(color: UIColor) -> (UIView) -> Void {
  return {
    $0.backgroundColor = color
    $0.tintColor = .white
  }
}

let roundedStyle: (UIView) -> Void = {
  $0.clipsToBounds = true
  $0.layer.cornerRadius = 10
}

let baseTextFieldStyle: (UITextField) -> Void =
  roundedStyle
    <> borderStyle(color: UIColor(white: 0.75, alpha: 1), width: 1)
    <> { (tf: UITextField) in
      tf.borderStyle = .roundedRect
      tf.heightAnchor.constraint(equalToConstant: 44).isActive = true
}



let filledBlackButtonStyle =
  roundedButtonStyle
  <> {
      $0.backgroundColor = .black
      $0.tintColor = .white
}

let borderButtonStyle  =
  roundedButtonStyle
    <> borderStyle(color: .black, width: 2)



func filledRoundedButtonStyle(color: UIColor) -> (UIButton) -> Void {
    return roundedButtonStyle
    <> {
      $0.backgroundColor = color
    }
}
