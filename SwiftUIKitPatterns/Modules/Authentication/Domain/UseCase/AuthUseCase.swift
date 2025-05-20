//
//  AuthUseCase.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 20/5/25.
//


protocol AuthUseCase {
    func requestOTP(phone: String) async throws -> OTPResponse
    func verifyOTP(phone: String, code: String) async throws -> VerifyOTPResponse
}
