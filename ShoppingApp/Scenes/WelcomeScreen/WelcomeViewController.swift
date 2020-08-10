//
//  WelcomeViewController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 06.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    var flowDelegate: AppFlowControllerDelegate?
    
    let welcomeLabel = UILabel(frame: .zero)
    let startButton = CustomButton()
    
    var viewModel: WelcomeViewModel
    
    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        setupCostraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       // DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
       //     self.flowDelegate?.welcomeControllerDidFinish(self)
       // }
    }
    
    @objc private func didTapButton(_ sender: Any) {
        viewModel.inputs.didTapStartButton()
    }
    
    private func bind() {
        viewModel.outputs.showMainScreen = {
            //guard let self = self else { return }
            self.flowDelegate?.welcomeControllerDidFinish(self)
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        welcomeLabel.text = "Welcome to the Shopping App!"
        
        startButton.set(backgroundColor: .systemGreen, title: "Start")
        startButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        view.addSubviews(welcomeLabel, startButton)
        
    }
}

// MARK: - UI Costraints

extension WelcomeViewController {
    private func setupCostraints() {
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
