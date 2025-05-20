//
//  DefaultAuthRepository.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 19/5/25.
//


final class DefaultAuthRepository: AuthRepository {
    private let network: NetworkServicing

    init(network: NetworkServicing) {
        self.network = network
    }

    func sendOTP(to phone: String) async throws -> OTPResponse {
        let requestModel = OTPRequestBody(phone: phone)
        return try await network.send(AuthAPIRequest.requestOTP(requestModel))
    }

    func verifyOTP(phone: String, code: String) async throws -> VerifyOTPResponse {
        let requestModel = VerifyOTPRequestBody(phone: phone, otp: code)
        return try await network.send(AuthAPIRequest.verifyOTP(requestModel))
    }
}
