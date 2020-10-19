//
//  UIImage+Ext.swift
//  Utils
//
//  Created by Christian Slanzi on 04.10.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

// CREATE AN IMAGE FROM A COLOR
public extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    static func from(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        return self.init(cgImage: cgImage)
    }
}

// REPRESET AN UIIMAGE WITH A STRING AND VICE VERSA
public extension UIImage {
    func toBase64() -> String {
        let imageData = self.jpegData(compressionQuality: 1)!
        let strBase64 = imageData.base64EncodedString()
        return strBase64
    }
    convenience init(string: String) {
        if let imageData = Data(base64Encoded: string) {
            self.init(data: imageData)!
        } else {
            self.init()
        }
    }
}
