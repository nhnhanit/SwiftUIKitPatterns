//
//  APIRequest.swift
//  SwiftUI_0325
//
//  Created by hongnhan on 11/4/25.
//

import Foundation

protocol APIRequest {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}


