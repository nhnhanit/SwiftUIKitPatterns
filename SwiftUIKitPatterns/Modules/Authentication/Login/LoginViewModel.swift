//
//  LoginViewModel.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 15/5/25.
//


import Combine
import Foundation

final class LoginViewModel {
    @Published var phoneNumber: String = ""

    var isContinueEnabled: AnyPublisher<Bool, Never> {
        $phoneNumber
            .map { $0.count >= 9 && $0.hasPrefix("0") }
            .eraseToAnyPublisher()
    }

    // Closure for navigation, inject coordinator
    var onPhoneSubmitted: ((String) -> Void)?

    func submitPhoneNumber() {
        let trimmed = phoneNumber.trimmingCharacters(in: .whitespaces)
        onPhoneSubmitted?(trimmed)
    }
}
