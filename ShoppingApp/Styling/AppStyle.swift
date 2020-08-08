//
//  AppStyle.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 30.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

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

let roundedButtonStyle =
  baseButtonStyle
    <> roundedStyle

let filledBlackButtonStyle =
  roundedButtonStyle
  <> {
      $0.backgroundColor = .black
      $0.tintColor = .white
}

let borderButtonStyle  =
  roundedButtonStyle
    <> borderStyle(color: .black, width: 2)

//let filledButtonStyle =
//  roundedButtonStyle
//  <> filledStyle(color: .black)

func filledButtonStyle(color: UIColor) -> (UIButton) -> Void {
    return {
      $0.backgroundColor = color
    }
}

func filledRoundedButtonStyle(color: UIColor) -> (UIButton) -> Void {
    return roundedButtonStyle
    <> {
      $0.backgroundColor = color
    }
}
