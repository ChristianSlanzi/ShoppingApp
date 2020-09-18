//
//  CaptionView.swift
//  CustomViews
//
//  Created by Christian Slanzi on 22.02.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import UIKit

class CaptionView: UIView {
    var label: UILabel?
    var captionImageView: UIImageView?
    
    let titleIconSize = CGFloat(25)
    let margin = CGFloat(10)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        backgroundColor = UIColor.brand(for: SettingsService.shared.appTheme)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        label.textAlignment = .center
        
        label.font = .systemFont(ofSize: 20)//UIFont(name: "LeagueGothic-Regular", size: 25)
        label.textColor = .white
        addSubview(label)
        self.label = label
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(title: String) {
        label?.text = title
    }
    
    func setTitleIcon(image: UIImage, tintColor: UIColor) {
        
        var offset = CGFloat(0)
        self.label?.sizeToFit()
        
        if let labelFrame = self.label?.frame {
            let captionSize = labelFrame.width + titleIconSize + margin
            let labelX = (UIScreen.main.bounds.width - captionSize)/2 + (titleIconSize+margin)
            let frame = CGRect(x: labelX, y: 0, width: labelFrame.width, height: 60)
            self.label?.frame = frame
            offset = labelX - titleIconSize - margin
        } else {
           offset = (UIScreen.main.bounds.width - titleIconSize)/2
        }
        
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: offset, y: 60/2 - titleIconSize/2, width: titleIconSize, height: titleIconSize)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = tintColor
        addSubview(imageView)
        self.captionImageView = imageView
    }
        
}
