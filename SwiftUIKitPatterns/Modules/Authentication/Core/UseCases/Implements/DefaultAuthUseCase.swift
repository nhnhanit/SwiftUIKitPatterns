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

    func requestOTP(phone: String) async throws -> OTPRespone {
        let otpDTO = try await repository.sendOTP(to: phone)
        return otpDTO.toDomain()
    }

    func verifyOTP(phone: String, code: String) async throws -> VerifyOTPRespone {
        let verifyOtpDTO = try await repository.verifyOTP(phone: phone, code: code)
        return verifyOtpDTO.toDomain()
    }
}
