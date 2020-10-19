//
//  NSMutableAttributedString+Ext.swift
//  Utils
//
//  Created by Christian Slanzi on 13.10.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

public extension NSMutableAttributedString {

    func setAsLink(textToFind: String, linkURL: String) -> Bool {

        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
    
    func setAsAction(textToFind: String, colorToSet: UIColor) -> Bool {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            
//            let linkAttributes: [NSAttributedString.Key : Any] = [
//                NSAttributedString.Key.foregroundColor : UIColor.blue /*, NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleSingle.rawValue,
//                NSLinkAttributeName: "http://www.apple.com"*/]
//            attributedString.setAttributes(linkAttributes, range:foundRange)
//
            self.addAttribute(.foregroundColor, value: colorToSet, range: foundRange)
            
            return true
        }
        return false
        
    }
}

private let attributedString = NSMutableAttributedString(string: "I love stackoverflow!")
private let linkWasSet = attributedString.setAsLink(textToFind: "stackoverflow", linkURL: "http://stackoverflow.com")
private func testLink() {
    if linkWasSet {
        // adjust more attributedString properties
    }
}
