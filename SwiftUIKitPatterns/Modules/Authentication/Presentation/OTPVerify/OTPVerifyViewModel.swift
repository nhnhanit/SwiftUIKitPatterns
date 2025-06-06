//
//  OTPVerifyViewModel.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 15/5/25.
//


import Combine
import Foundation

final class OTPVerifyViewModel {
    
    var onVerifySuccess: (() -> Void)?
    let phoneNumber: String
    let otpExpiresIn: Int
    @Published var otpVerifyViewState: OTPVerifyViewState

    init(phoneNumber: String, otpExpiresIn: Int) {
        self.phoneNumber = phoneNumber
        self.otpExpiresIn = otpExpiresIn
        
        otpVerifyViewState = OTPVerifyViewState(instructionText: "OTP sent to phone number: \(phoneNumber)",
                                                initialCountdown: otpExpiresIn)
    }
    
    @Published var otpCode: String = ""
    var isVerifyEnabled: AnyPublisher<Bool, Never> {
        $otpCode
            .map { $0.count == 6 }
            .eraseToAnyPublisher()
    }

    func verifyOTP() {
        
        // TODO: call API verify OTP
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            
            let token = "1234"
            SessionManager.shared.logIn(with: token)
            self?.onVerifySuccess?()
        }
    }
}
