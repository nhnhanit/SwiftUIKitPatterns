//
//  NetworkError.swift
//  SwiftUI_0325
//
//  Created by hongnhan on 14/4/25.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case decodingError(underlying: Error)
    case serverError(statusCode: Int, data: Data?)
    case urlError(URLError)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .decodingError(let err):
            return "Failed to decode response: \(err.localizedDescription)"
        case .serverError(let code, let data):
            if let data = data, let serverMessage = String(data: data, encoding: .utf8) {
                return "Server error \(code): \(serverMessage)"
            }
            return "Server returned an error with status code \(code)."
        case .urlError(let err):
            return "Network error: \(err.localizedDescription)"
        case .unknown(let err):
            return "Unexpected error: \(err.localizedDescription)"
        }
    }
}

