//
//  OTPResponse.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 19/5/25.
//


//struct OTPResponse: Decodable {
//    let success: Bool
//    let message: String
//}

struct OTPResponse: Decodable {
    let title: String
    let body: String
    let userId: String
    let id: Int
}

//struct LoginResponse: Decodable {
//    let accessToken: String
//    let refreshToken: String
//    let userId: String
//}

struct LoginResponse: Decodable {
    let title: String
    let body: String
    let userId: String
    let id: Int
}
