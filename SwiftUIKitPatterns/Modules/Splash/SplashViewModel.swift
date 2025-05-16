//
//  SplashViewModel.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 16/5/25.
//

import Foundation

final class SplashViewModel {
    
    var onFinish: ((Bool) -> Void)?
    
    init() {}
    
    func checkLoginStatus() {
        
        // Delay 0.5s for call API
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if SessionManager.shared.isLoggedIn {
                self.onFinish?(true)
            } else {
                self.onFinish?(false)
            }
        }
    }
    
}
