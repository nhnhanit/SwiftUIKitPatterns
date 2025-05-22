//
//  PostAPIRequest.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 22/5/25.
//

import Foundation

enum PostAPIRequest: APIRequest, AuthorizedRequestBuilder {
    
    case fetchPosts
    
    var requiresAuthorization: Bool {
        switch self {
        case .fetchPosts:
            return false // API public dont need accessToken
//        case .fetchComments, .fetchUser, .deletePost:
//            return true
        }
    }
    
    var baseURL: URL {
        URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .fetchPosts:
            return "/posts"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchPosts:
            return .get
        }
    }
    
    var headers: [String : String]? {
        authorizedHeaders(baseHeaders: ["Content-Type": "application/json; charset=UTF-8"])
    }
    
    var queryItems: [URLQueryItem]? { nil }
    
    var body: Data? { nil }
}
