//
//  AuthRepository.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 20/5/25.
//


protocol AuthRepository {
    func sendOTP(to phone: String) async throws -> OTPResponseDTO
    func verifyOTP(phone: String, code: String) async throws -> VerifyOTPResponseDTO
}
