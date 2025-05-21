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

    func sendOTP(to phone: String) async throws -> OTPResponseDTO {
        let requestModel = OTPRequestModel(phone: phone)
        return try await network.send(AuthAPIRequest.requestOTP(requestModel))
    }

    func verifyOTP(phone: String, code: String) async throws -> VerifyOTPResponseDTO {
        let requestModel = VerifyOTPRequestModel(phone: phone, otp: code)
        return try await network.send(AuthAPIRequest.verifyOTP(requestModel))
    }
}
