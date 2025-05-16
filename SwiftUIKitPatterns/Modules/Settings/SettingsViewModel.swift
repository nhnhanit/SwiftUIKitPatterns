//
//  SettingsViewModel.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 14/5/25.
//

import Foundation

final class SettingsViewModel {
    private let navigator: SettingsNavigator
    
    init(navigator: SettingsNavigator) {
        self.navigator = navigator
    }
    
    func logoutTapped() {
        SessionManager.shared.logOut()
        
        DispatchQueue.main.async {
            AppRoot.shared.appCoordinator?.resetToSplash()
        }
        
        // check
        print("logoutTapped Login?", SessionManager.shared.isLoggedIn)
    }
    
    func userProfileTapped() {
        navigator.navigateToUserProfile()
    }
}
