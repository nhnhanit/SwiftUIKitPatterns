//
//  DefaultAuthUseCase.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 19/5/25.
//


final class DefaultAuthUseCase: AuthUseCase {
    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }

    func requestOTP(phone: String) async throws -> Otp {
        return try await repository.sendOTP(to: phone)
    }

    func verifyOTP(phone: String, code: String) async throws -> VerifyOtp {
        return try await repository.verifyOTP(phone: phone, code: code)
    }
}
