//
//  VerifyOTPResponse.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 19/5/25.
//


//struct LoginResponse: Decodable {
//    let accessToken: String
//    let refreshToken: String
//    let userId: String
//}

struct VerifyOTPResponse: Decodable {
    let title: String
    let body: String
    let userId: String
    let id: Int
}
