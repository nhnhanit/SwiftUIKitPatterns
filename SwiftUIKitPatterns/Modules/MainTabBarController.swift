//
//  MainTabBarController.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 14/5/25.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let home = UINavigationController(rootViewController: HomeViewController())
        home.tabBarItem = UITabBarItem(title: "Home", image: .init(systemName: "house"), tag: 0)

        let settings = UINavigationController(rootViewController: SettingsViewController())
        settings.tabBarItem = UITabBarItem(title: "Settings", image: .init(systemName: "gear"), tag: 1)

        viewControllers = [home, settings]
    }
}
