//
//  NetworkLogger.swift
//  SwiftUI_0325
//
//  Created by hongnhan on 14/4/25.
//

import SwiftUI

struct NetworkLogger {
    static func log(request: URLRequest) {
#if DEBUG
        print("\n📤 [API Request]")
        print("URL: \(request.url?.absoluteString ?? "None")")
        print("Method: \(request.httpMethod ?? "None")")
        print("Headers: \(request.allHTTPHeaderFields ?? [:])")
        
        if let body = request.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            print("Body: \(bodyString)")
        }
#endif
    }

    static func log(response: URLResponse?, data: Data?) {
#if DEBUG
        print("\n📥 [API Response]")
        if let httpResponse = response as? HTTPURLResponse {
            print("Status Code: \(httpResponse.statusCode)")
            print("Headers: \(httpResponse.allHeaderFields)")
        }
        
        if let data = data,
           let jsonString = String(data: data, encoding: .utf8) {
            print("Response Body: \(jsonString)")
        }
#endif
    }

    static func log(error: Error) {
#if DEBUG
        print("\n❌ [API Error]")
        print("Error: \(error.localizedDescription)")
#endif
    }
    
    static func log(duration: TimeInterval) {
#if DEBUG
        print("⏱️ [API Duration]: \(duration) seconds")
#endif
    }
}
