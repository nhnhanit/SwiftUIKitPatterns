//
//  LoginViewController.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 14/5/25.
//

import UIKit

final class LoginViewController: UIViewController {

    var onLoginSuccess: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Login"

        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func loginTapped() {
        // TODO: validate login
        onLoginSuccess?()
    }
}
