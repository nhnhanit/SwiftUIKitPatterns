//
//  LoginViewModel.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 15/5/25.
//


import Combine
import Foundation

final class LoginViewModel {
    private let authUseCase: AuthUseCase

    init(authUseCase: AuthUseCase) {
        self.authUseCase = authUseCase
    }
    
    @Published var phoneNumber: String = ""

    var isContinueEnabled: AnyPublisher<Bool, Never> {
        $phoneNumber
            .map { $0.count >= 9 && $0.hasPrefix("0") }
            .eraseToAnyPublisher()
    }

    // Closure for navigation, inject coordinator
    var onPhoneSubmitted: ((String) -> Void)?

    func continueButtonTapped() async {
        let phone = phoneNumber.trimmingCharacters(in: .whitespaces)
        
        do {
            _ = try await authUseCase.requestOTP(phone: phone)
            onPhoneSubmitted?(phone)
        } catch {
            print("Failed to request OTP: \(error)")
            // TODO: bạn có thể gọi delegate, closure hoặc gắn thêm published error
            
            DispatchQueue.main.async {
                AlertManager.shared.show(type: .info(title: "error!", message: "\(error.localizedDescription)", dismissTitle: "ok"))
            }
        }
    }
}
