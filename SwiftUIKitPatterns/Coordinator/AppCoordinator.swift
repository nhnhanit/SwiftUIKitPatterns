//
//  AppCoordinator.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 14/5/25.
//

import UIKit
import Combine

final class AppCoordinator {
    private let window: UIWindow
    
    private var splashCoordinator: SplashCoordinator?
    private var authCoordinator: AuthCoordinator?
    private var mainTabCoordinator: MainTabCoordinator?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        print("After restart: logged in?", SessionManager.shared.isLoggedIn)
        showSplash()
    }
    
    func showSplash() {
        let coordinator = SplashCoordinator()
        splashCoordinator = coordinator
        
        coordinator.onFinish = { [weak self] isLoggedIn in
            if isLoggedIn {
                self?.showMain(tab: .home)
            } else {
                self?.startAuthFlow()
            }
        }
        let splashVC = coordinator.start()
        setRootViewController(splashVC)
    }
    
    func startAuthFlow() {
        let coordinator = AuthCoordinator()
        authCoordinator = coordinator
        
        coordinator.onFinish = { [weak self] in
            self?.showMain(tab: .home)
        }
        
        let authVC = coordinator.start()
        setRootViewController(authVC)
    }
    
    func showMain(tab: MainTab) {
        let coordinator = MainTabCoordinator()
        mainTabCoordinator = coordinator
        
        let mainVC = coordinator.start(withInitialTab: tab)
        setRootViewController(mainVC)
    }
    
    
    func resetToSplash() {
        splashCoordinator = nil
        authCoordinator = nil
        mainTabCoordinator = nil
        showSplash()
    }
    
    private func setRootViewController(_ vc: UIViewController) {
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        // Optional: Add custom transition
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
    
    public func handleDeeplink() {
        // Handle deeplink globally
    }
}
