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
        navigator.showLogoutConfirmAlert(onConfirm: { [weak self] in
            print("onConfirm logout")
            
            // TODO: - Call API logout
            
            self?.navigator.logout()
        })
    }
    
    func userProfileTapped() {
        navigator.navigateToUserProfile()
    }
}
