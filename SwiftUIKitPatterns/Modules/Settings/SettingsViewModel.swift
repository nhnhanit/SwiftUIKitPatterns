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
        navigator.logout()
    }
    
    func userProfileTapped() {
        navigator.navigateToUserProfile()
    }
}
