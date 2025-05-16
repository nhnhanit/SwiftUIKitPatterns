//
//  OTPVerifyViewModel.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 15/5/25.
//


import Combine
import Foundation

final class OTPVerifyViewModel {
    @Published var otpCode: String = ""

    let phoneNumber: String

    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }

    var isVerifyEnabled: AnyPublisher<Bool, Never> {
        $otpCode
            .map { $0.count == 6 }
            .eraseToAnyPublisher()
    }

    func verifyOTP() {
        
        // TODO: call API verify OTP
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let token = "1234"
            SessionManager.shared.logIn(with: token)
            
            DispatchQueue.main.async {
                AppRoot.shared.appCoordinator?.showMain(tab: .home)
            }
            
            // check
            print("verifyOTP Login?", SessionManager.shared.isLoggedIn)
        }
    }
}
