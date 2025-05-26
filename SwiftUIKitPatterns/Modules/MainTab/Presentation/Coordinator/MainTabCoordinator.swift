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
    var postsListNav: UINavigationController?
    
    func start(withInitialTab tab: MainTab) -> UITabBarController {
        
        // MARK: - postsListNav
        
        let networkService = DefaultNetworkService()
        let postRepository = DefaultPostRepository(network: networkService)
        let postUseCase = DefaultPostUseCase(repository: postRepository)

        let postsListViewModel = PostsListViewModel(postUseCase: postUseCase, navigator: self)
        let postsListVC = PostsListModuleBuilder.build(viewModel: postsListViewModel)
        postsListVC.title = "Posts List"
        let postsListNav = UINavigationController(rootViewController: postsListVC)
        postsListNav.tabBarItem = UITabBarItem(title: "Home", image: nil, tag: 0)
        
        self.postsListNav = postsListNav
        
        // MARK: - settingsNav
        
        let settingsVC = SettingsModuleBuilder.build(navigator: self)
        settingsVC.title = "Settings"
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        settingsNav.tabBarItem = UITabBarItem(title: "Settings", image: nil, tag: 1)
        
        self.settingsNav = settingsNav
        
        // MARK: - tabBarController
        tabBarController.viewControllers = [postsListNav, settingsNav]
        
        switch tab {
        case .home:
            tabBarController.selectedIndex = 0
        case .settings:
            tabBarController.selectedIndex = 1
        }
        
        return tabBarController
    }
}
