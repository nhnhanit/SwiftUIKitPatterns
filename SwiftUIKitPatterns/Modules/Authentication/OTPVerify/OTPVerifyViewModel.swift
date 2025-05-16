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
    var onVerified: (() -> Void)?

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
        
#warning("hardcode for testing")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            SessionManager.shared.logIn(with: <#T##String#>)
        }
    }
}
