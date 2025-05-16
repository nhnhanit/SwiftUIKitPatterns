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
    
    func start(withInitialTab tab: MainTab) -> UITabBarController {
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: nil, tag: 0)
        
        let settingsVC = SettingsModuleBuilder.build(navigator: self)
        
        tabBarController.viewControllers = [homeVC, settingsVC]
        
        switch tab {
        case .home:
            tabBarController.selectedIndex = 0
        case .settings:
            tabBarController.selectedIndex = 1
        }
        
        return tabBarController
    }
}
