//
//  UIFont+Ext.swift
//  Utils
//
//  Created by Christian Slanzi on 03.10.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

public extension UIFont {
    /// Returns a bolded version of `self`.
    var bolded: UIFont {
        return self.fontDescriptor.withSymbolicTraits(.traitBold).map { UIFont(descriptor: $0, size: 0.0) } ?? self
    }
    
    /// Returns a italicized version of `self`.
    var italicized: UIFont {
        return self.fontDescriptor.withSymbolicTraits(.traitItalic)
            .map { UIFont(descriptor: $0, size: 0.0) } ?? self
    }
    
    var smallCaps: UIFont {
        let attributes: [UIFontDescriptor.FeatureKey: Any] = [
            .featureIdentifier: kLowerCaseType,
            .typeIdentifier: kLowerCaseSmallCapsSelector
        ]
        let descriptor = fontDescriptor.addingAttributes([
            .featureSettings : [attributes],
            .name: fontName
        ])
        
        return UIFont(descriptor: descriptor, size: pointSize)
    }
}
