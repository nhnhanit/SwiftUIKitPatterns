//
//  AuthUseCase.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 19/5/25.
//


protocol AuthUseCase {
    func requestOTP(phone: String) async throws -> OTPResponse
    func verifyOTP(phone: String, code: String) async throws -> LoginResponse
}

final class DefaultAuthUseCase: AuthUseCase {
    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }

    func requestOTP(phone: String) async throws -> OTPResponse {
        try await repository.sendOTP(to: phone)
    }

    func verifyOTP(phone: String, code: String) async throws -> LoginResponse {
        try await repository.verifyOTP(phone: phone, code: code)
    }
}
