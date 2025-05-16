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

    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
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
            
            // check
            print("verifyOTP Login?", SessionManager.shared.isLoggedIn)
            
            self?.onVerifySuccess?()
            
//            DispatchQueue.main.async {
//                AppRoot.shared.appCoordinator?.showMain(tab: .home)
//            }
            
        }
    }
}
