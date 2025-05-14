//
//  HomeViewController.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 14/5/25.
//

import UIKit

final class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
    }
}

final class SettingsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .systemBackground
    }
}
