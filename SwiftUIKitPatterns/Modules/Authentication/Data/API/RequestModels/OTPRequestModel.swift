//
//  OTPRequestModel.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 20/5/25.
//


struct OTPRequestModel: Encodable {
    let phone: String
    let otpExpiresIn: Int = 30 // seconds
}
