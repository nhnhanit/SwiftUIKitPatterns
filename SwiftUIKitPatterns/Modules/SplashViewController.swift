//
//  SplashViewController.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 14/5/25.
//

import UIKit

final class SplashViewController: UIViewController {
    
    var onFinish: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTitleLabel()
        
        // Giả lập loading & check login
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let isLoggedIn = false // TODO: kiểm tra token thực tế
            self.onFinish?(isLoggedIn)
        }
    }
    
    private func setupTitleLabel() {
        let label = UILabel()
        label.text = "Splash Screen"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
