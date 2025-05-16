//
//  MainTab.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 15/5/25.
//

import UIKit

enum MainTab {
    case home, settings
}

final class MainTabCoordinator {
    
    let tabBarController = UITabBarController()
    var onLogout: (() -> Void)?
    
    var settingsNav: UINavigationController?
    
    func start(withInitialTab tab: MainTab) -> UITabBarController {
        let homeVC = HomeViewController()
        homeVC.title = "Home"
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: nil, tag: 0)
        
        let settingsVC = SettingsModuleBuilder.build(navigator: self)
        settingsVC.title = "Settings"
        var settingsNav = UINavigationController(rootViewController: settingsVC)
        settingsNav.tabBarItem = UITabBarItem(title: "Settings", image: nil, tag: 1)
        
        self.settingsNav = settingsNav
        tabBarController.viewControllers = [homeNav, settingsNav]
        
        switch tab {
        case .home:
            tabBarController.selectedIndex = 0
        case .settings:
            tabBarController.selectedIndex = 1
        }
        
        return tabBarController
    }
}
