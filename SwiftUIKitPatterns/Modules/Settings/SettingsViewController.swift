//
//  SettingsViewController.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 14/5/25.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    let viewModel: SettingsViewModel

    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .systemBackground
        
        let logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        
        let profileButton = UIButton(type: .system)
        profileButton.setTitle("Go to Profile", for: .normal)
        profileButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoutButton)
        view.addSubview(profileButton)
        
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            profileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileButton.topAnchor.constraint(equalTo: logoutButton.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func logoutTapped() {
        viewModel.logoutTapped()
    }
    
    @objc private func profileTapped() {
        viewModel.userProfileTapped()
    }
}

