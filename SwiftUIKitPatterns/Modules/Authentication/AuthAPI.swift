//
//  AuthAPI.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 19/5/25.
//

import Foundation

enum AuthAPI: APIRequest {
    
    case requestOTP(phone: String)
    case verifyOTP(phone: String, otp: String)
    
    var baseURL: URL {
        URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .requestOTP, .verifyOTP:
            return "/posts"
        }
    }
    
    var method: String {
        switch self {
        case .requestOTP, .verifyOTP:
            return HTTPMethod.post.rawValue
        }
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json; charset=UTF-8"]
    }
    
    var queryItems: [URLQueryItem]? { nil }
    
    var body: Data? {
        switch self {
        case .requestOTP(let phone):
            return try? JSONEncoder().encode(["title": phone, "body": phone, "userId": "1"])
        case .verifyOTP(let phone, let otp):
            return try? JSONEncoder().encode(["title": phone, "body": otp, "userId": "1"])
        }
    }
}
