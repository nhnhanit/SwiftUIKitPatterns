//
//  SettingsViewModel.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 14/5/25.
//

final class SettingsViewModel {
    private let navigator: SettingsNavigator
    private let appRoot: AppRootProtocol
    
    init(appRoot: AppRootProtocol = AppRoot.shared,
         navigator: SettingsNavigator) {
        self.appRoot = appRoot
        self.navigator = navigator
    }
    
    func logoutTapped() {
        self.appRoot.resetToSplash()
    }
    
    func userProfileTapped() {
        navigator.navigateToUserProfile()
    }
}
