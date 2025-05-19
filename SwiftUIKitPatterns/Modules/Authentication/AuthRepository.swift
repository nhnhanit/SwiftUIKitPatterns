//
//  AuthRepository.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 19/5/25.
//


protocol AuthRepository {
    func sendOTP(to phone: String) async throws -> OTPResponse
    func verifyOTP(phone: String, code: String) async throws -> LoginResponse
}

final class DefaultAuthRepository: AuthRepository {
    private let network: NetworkServicing

    init(network: NetworkServicing) {
        self.network = network
    }

    func sendOTP(to phone: String) async throws -> OTPResponse {
        try await network.send(AuthAPI.requestOTP(phone: phone))
    }

    func verifyOTP(phone: String, code: String) async throws -> LoginResponse {
        try await network.send(AuthAPI.verifyOTP(phone: phone, otp: code))
    }
}
