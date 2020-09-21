//
//  PopupNotification.swift
//  CustomViews
//
//  Created by Christian Slanzi on 22.02.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import UIKit

public typealias Completion = () -> Void

public class PopupNotification: UIView, Modal {
    var backgroundView: UIView = UIView()
    
    var dialogView: UIView = UIView()
    
    var btnBackground: UIButton!
    var bgWindow: UIView!
    var lblDate: UILabel!
    var lblHeadline: UILabel!
    var lblMessage: UILabel!
    var btnOk: UIButton!
    var notification: InfoNotification! {
        didSet {
            self.fillContent()
        }
    }
    var completion: Completion?
    
    // MARK: - ColorUpdatable
    
    public var theme: Theme = Current.theme {
        didSet {
            guard oldValue != theme else { return }
            updateColors(for: theme)
        }
    }

    init(with completion:@escaping Completion) {
        super.init(frame: .zero)
        self.setup()
        self.completion = completion
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBtnClose))) //TODO: to fix, it doesn't work
        addSubview(backgroundView)
        
        self.backgroundColor = UIColor(hexFromString: "0x000000", alpha: 0.7)
        
        self.btnBackground = UIButton()
        self.btnBackground.addTarget(self, action: #selector(onBtnClose), for: .touchUpInside)
        dialogView.addSubview(self.btnBackground)
        
        self.bgWindow = UIView()
        self.bgWindow.backgroundColor = UIColor.white
        self.bgWindow.layer.cornerRadius = 5
        dialogView.addSubview(self.bgWindow)
        
        self.lblDate = UILabel()
        //[self.bgWindow addSubview:self.lblDate];
        self.lblDate.font = UIFont(name: "HelveticaNeue-Thin", size: 12.0)
        self.lblDate.textColor = UIColor.black
        self.lblDate.numberOfLines = 1
        self.lblDate.textAlignment = .left
        
        self.lblHeadline = UILabel()
        self.bgWindow.addSubview(self.lblHeadline)
        self.lblHeadline.font = UIFont(name: "LeagueGothic-Regular", size: 32.0)
        self.lblHeadline.textColor = .brand(for: theme)  //grün wifimedia4patients
        self.lblHeadline.numberOfLines = 0
        self.lblHeadline.textAlignment = .center
        
        self.lblMessage = UILabel()
        self.bgWindow.addSubview(self.lblMessage)
        self.lblMessage.font = UIFont(name: "HelveticaNeue", size: 22.0)
        self.lblMessage.textColor = UIColor.gray
        self.lblMessage.numberOfLines = 0
        self.lblMessage.textAlignment = .center
        
        self.btnOk = UIButton()
        self.btnOk.addTarget(self, action: #selector(onBtnClose), for: .touchUpInside)
        self.btnOk.backgroundColor = .brand(for: theme)  //grün wifimedia4patients
        self.btnOk.setTitle("Ok", for: .normal)
        self.btnOk.setTitleColor(UIColor.white, for: .normal)
        self.btnOk.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 32.0)
        self.btnOk.layer.cornerRadius = 3
        self.bgWindow.addSubview(self.btnOk)
        
        dialogView.backgroundColor = UIColor.white
        dialogView.layer.cornerRadius = 6
        dialogView.clipsToBounds = true
        addSubview(dialogView)
        
    }
    
    @objc func onBtnClose() {
        if let completion = self.completion {
            completion()
        }
        //self.removeFromSuperview()
        dismiss(animated: true)
    }
    
    private func fillContent() {
        self.lblHeadline.text = self.notification.headline
        self.lblMessage.text = self.notification.message
        
        let prettyDateFormatter = DateFormatter()
        prettyDateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
    
        self.lblDate.text = prettyDateFormatter.string(from: self.notification.date) 
    }
    
    //func setNotification(notification: InfoNotification) {
    //    self.notification = notification
    //    self.fillContent()
    //}
    
    public override func sizeToFit() {
        let winW = self.frame.size.width - 80
        self.lblDate.sizeToFit()
        self.lblDate.frame = CGRect(x: 20, y: 20, width: self.lblDate.frame.size.width, height: self.lblDate.frame.size.height)
        var dummy = self.lblDate.frame
        
        dummy = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        self.lblHeadline.frame = CGRect(x: 20, y: 20, width: winW-40, height: 0)
        self.lblHeadline.sizeToFit()
        self.lblHeadline.frame = CGRect(x: 20, y: 20, width: winW-40, height: self.lblHeadline.frame.size.height)
        dummy = self.lblHeadline.frame
        //dummy=self.lblHeadline.frame=CGRectMake(20, CGRectGetMaxY(dummy), self.lblHeadline.frame.size.width, self.lblHeadline.frame.size.height);
        
        self.lblMessage.frame = CGRect(x: 20, y: 0, width: winW-40, height: 0)
            self.lblMessage.sizeToFit()
        self.lblMessage.frame=CGRect(x: 20, y: dummy.maxY+20, width: winW-40, height: self.lblMessage.frame.size.height)
        dummy=self.lblMessage.frame
        var frame=self.frame
        frame.size.height=dummy.size.height+70
        
        self.btnBackground.frame=self.bounds
        
        let winH = self.lblMessage.frame.maxY+40+70
        
        dialogView.frame = CGRect(x: self.frame.size.width/2-winW/2, y: self.frame.size.height/2-winH/2, width: winW, height: winH)
        self.bgWindow.frame=CGRect(x: 0, y: 0, width: winW, height: winH)
        
        self.btnOk.frame=CGRect(x: 70, y: self.bgWindow.frame.size.height-70, width: self.bgWindow.frame.size.width-140, height: 50)
        
    }

    public override func layoutSubviews() {
        
    }
    
}

extension PopupNotification: ColorUpdatable {
    
    public func updateColors(for theme: Theme) {
        self.lblHeadline.textColor = .brand(for: theme)
        self.btnOk.backgroundColor = .brand(for: theme)
    }
    
}
