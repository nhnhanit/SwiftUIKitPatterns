//
//  AuthAPIRequest.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 19/5/25.
//

import Foundation

enum AuthAPIRequest: APIRequest {
    
    case requestOTP(OTPRequestBody)
    case verifyOTP(VerifyOTPRequestBody)
    
    var baseURL: URL {
        URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .requestOTP, .verifyOTP:
            return "/posts"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .requestOTP, .verifyOTP:
            return .post
        }
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json; charset=UTF-8"]
    }
    
    var queryItems: [URLQueryItem]? { nil }
    
    var body: Data? {
        switch self {
        case .requestOTP(let model):
            return try? JSONEncoder().encode(model)
        case .verifyOTP(let model):
            return try? JSONEncoder().encode(model)
        }
    }
}
