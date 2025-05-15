//
//  AppCoordinator.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 14/5/25.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private var navigationController: UINavigationController

    private var authCoordinator: AuthCoordinator?
    private var mainTabCoordinator: MainTabCoordinator?

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        showSplash()
    }

    func showSplash() {
        let splashVC = SplashViewController()
        splashVC.onFinish = { [weak self] isLoggedIn in
            if isLoggedIn {
                self?.showMain(tab: .home)
            } else {
                self?.startAuthFlow()
            }
        }
        navigationController.setViewControllers([splashVC], animated: false)
    }

    func startAuthFlow() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        self.authCoordinator = authCoordinator
        authCoordinator.onAuthSuccess = { [weak self] in
            self?.showMain(tab: .home)
        }
        authCoordinator.start()
    }

    func showMain(tab: MainTab) {
        let mainTabCoordinator = MainTabCoordinator()
        self.mainTabCoordinator = mainTabCoordinator
        let mainVC = mainTabCoordinator.start(withInitialTab: tab)
        navigationController.setViewControllers([mainVC], animated: true)
    }

    func resetToSplash() {
        mainTabCoordinator = nil
        authCoordinator = nil
        showSplash()
    }
}
