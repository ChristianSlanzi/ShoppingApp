//
//  UIColorExtensions.swift
//  Fitness-Notiz
//
//  Created by Christian Slanzi on 06.11.19.
//  Copyright © 2019 Christian Slanzi. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: .random(),
                       green: .random(),
                       blue: .random(),
                       alpha: 1.0)
    }
}

// CREATE A COLOR WITH A HEX CODE
public extension UIColor {
    convenience init(string hex: String) {
        // do some basic cleaning
        var colorString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        // remove the # if present
        if colorString.hasPrefix("#") {
            colorString.remove(at: colorString.startIndex)
        }
        
        // guarantee 6 digits
        if colorString.count != 6 {
            self.init(white: 0.5, alpha: 1.0)
        } else {
            //convert
            var rgbValue: UInt32 = 0
            Scanner(string: colorString).scanHexInt32(&rgbValue)
            
            //instanciate
            self.init(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0))
        }
        
    }
}

public extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }

    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            alpha: alpha
        )
    }
    
    convenience init(red: Int, green: Int, blue: Int, alpha: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(alpha) / 255.0
        )
    }

    // let's suppose alpha is the first component (ARGB)
    convenience init(argb: Int) {
        self.init(
            red: (argb >> 16) & 0xFF,
            green: (argb >> 8) & 0xFF,
            blue: argb & 0xFF,
            alpha: (argb >> 24) & 0xFF
        )
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let alpha, red, green, blue: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha) / 255)
    }
    
    convenience init(hexFromString: String, alpha: CGFloat = 1.0) {
        var cString: String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue: UInt32 = 10066329 //color #999999 if string has wrong format

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if cString.count == 6 {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

//example
let color = UIColor(string: "#ff0000")
