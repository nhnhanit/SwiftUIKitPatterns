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

    func sendOTP(to phone: String) async throws -> Otp {
        let requestModel = OTPRequestModel(phone: phone)
        let otpDTO: OTPResponseDTO = try await network.send(AuthAPIRequest.requestOTP(requestModel))
        
        return otpDTO.toDomain()
    }

    func verifyOTP(phone: String, code: String) async throws -> VerifyOtp {
        let requestModel = VerifyOTPRequestModel(phone: phone, otp: code)
        let verifyOtpDTO: VerifyOTPResponseDTO  = try await network.send(AuthAPIRequest.verifyOTP(requestModel))
        
        return verifyOtpDTO.toDomain()
    }
}
