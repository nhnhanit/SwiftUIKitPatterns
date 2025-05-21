//
//  VerifyOTPRequestModel.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 20/5/25.
//


struct VerifyOTPRequestModel: Encodable {
    let phone: String
    let otp: String
}
