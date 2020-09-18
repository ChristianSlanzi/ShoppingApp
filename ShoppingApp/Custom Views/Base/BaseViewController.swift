//
//  BaseViewController.swift
//  CustomViews
//
//  Created by Christian Slanzi on 22.02.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation
import UIKit

//TODO: public or open?
public class BaseViewController: UIViewController {
    
    var popup: PopupNotification?
    
    public var bgImageName: String?
    
    //TODO: move backgroundImageView to BaseViewController
    lazy var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView()
         backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
         if let imageName = bgImageName {
             backgroundImageView.image = UIImage(named: imageName)
         }
         backgroundImageView.contentMode = .scaleAspectFill
         return backgroundImageView
     }()
    
    public var theme: Theme = SettingsService.shared.appTheme {
        didSet {
            guard oldValue != theme else { return }
            updateColors(for: theme)
        }
    }
    
    // MARK: INIT
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LIFE CYCLE
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        setupViews()
        setupConstraints()
        setupActions()
        setupBehaviors()
    }
        
    //common func to init our view
    public func setupViews() {
        view.backgroundColor = .white
        
        if bgImageName != nil {
            //add background image
            view.addSubview(backgroundImageView)
        }
    }
    
    //common func to init behaviors, i.e. set delegates
    public func setupBehaviors() {
    }
    
    //common func to set autolayout constraints
    public func setupConstraints() {
        if bgImageName != nil {
            NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
    
    //common func to set actions with targets and selectors
    public func setupActions() {
      //addButton.addTarget(self, action: #selector(moveHeaderView), for: .touchUpInside)
    }
    
    public func updateColors(for theme: Theme) {
        view.backgroundColor = .contentBackground(for: theme)
    }
    
}

//TODO: can be this overriden?
extension BaseViewController: ColorUpdatable {
    
}

// MARK: PopupNotification

extension BaseViewController {
    public func showPopup(notification: InfoNotification, completion: @escaping Completion) {
        self.popup?.removeFromSuperview()
        
        self.popup = PopupNotification(with: completion)
        
        guard let popup = self.popup else { return }
        popup.notification = notification
        popup.frame=self.view.bounds
        popup.sizeToFit()
        self.view.addSubview(popup)
        
        popup.show(animated: true)
        
        // post-actions should go within completion closure, like as for the static version above
        if let isRemotePushNotification = popup.notification?.isRemotePushNotification {
            if isRemotePushNotification == 1 {
               refresh()
            }
             //allow refresh only for a push notification and not for server error messaging or it will keep showing popups because refresh send a new server request causing a new error and so on.
        }
    }
    
    @objc public func refresh() {
        
    }
}

extension BaseViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(
    _ gestureRecognizer: UIGestureRecognizer,
    shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
  ) -> Bool {
    return true
  }
}
