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
    
    // Closure for navigation, inject coordinator
    var onRequestOTPSuccess: ((Otp) -> Void)?
    var onShowAlert: ((AlertModel) -> Void)?

    @Published var isLoading: Bool = false
    @Published var phoneNumber: String = ""
    var isContinueEnabled: AnyPublisher<Bool, Never> {
        $phoneNumber
            .map { $0.count >= 9 && $0.hasPrefix("0") }
            .eraseToAnyPublisher()
    }
    
    func continueButtonTapped() async {
        let phone = phoneNumber.trimmingCharacters(in: .whitespaces)
        
        print("phone:", phone)
        // ✅ Step 1: Validate input
        guard isValidPhoneNumber(phone) else {
            self.onShowAlert?(AlertModel(
                title: "Invalid Input",
                message: "Phone number is not valid",
                actions: [
                    .ok()
                ]
            ))
            return
        }
        
        // ✅ Step 2: API call
        isLoading = true
        defer { isLoading = false }
        
        do {
            let otp = try await authUseCase.requestOTP(phone: phone)
            onRequestOTPSuccess?(otp)
        } catch {
            print("Failed to request OTP: \(error)")
            let alertModel = AlertModel(title: "Error", message: error.localizedDescription)
            self.onShowAlert?(alertModel)
        }
    }
    
    private func isValidPhoneNumber(_ phone: String) -> Bool {
        
        // TODO: - Replace with real logic (regex or use lib like PhoneNumberKit)
        
        return phone.count >= 10
    }
    
}
