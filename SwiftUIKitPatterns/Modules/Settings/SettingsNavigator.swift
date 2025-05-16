//
//  SettingsNavigator.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 15/5/25.
//

protocol SettingsNavigator: AnyObject {
    func navigateToUserProfile()
    func logout()
}

extension MainTabCoordinator: SettingsNavigator {
    
    func navigateToUserProfile() {
        let userProfileVC = UserProfileViewController()
        self.settingsNav?.pushViewController(userProfileVC, animated: true)
    }
    
    func logout() {
        self.onLogout?()
    }
    
}
