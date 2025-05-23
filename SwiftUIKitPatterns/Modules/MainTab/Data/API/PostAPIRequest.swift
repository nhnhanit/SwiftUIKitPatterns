//
//  PostAPIRequest.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 22/5/25.
//

import Foundation

enum PostAPIRequest: APIRequest, AuthorizedRequestBuilder {
    
    case fetchPosts(start: Int, limit: Int)
    case deletePost(postId: Int)
    
    var requiresAuthorization: Bool {
        switch self {
        case .fetchPosts:
            return false // API public dont need accessToken
        case .deletePost:
            return true
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
        case .deletePost(let postId):
            return "/posts/\(postId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchPosts:
            return .get
        case .deletePost:
            return .delete
        }
    }
    
    var headers: [String : String]? {
        authorizedHeaders(baseHeaders: ["Content-Type": "application/json; charset=UTF-8"])
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case let .fetchPosts(start, limit):
            return [
                URLQueryItem(name: "_start", value: "\(start)"),
                URLQueryItem(name: "_limit", value: "\(limit)")
            ]
        case .deletePost:
            return nil
        }}
    
    var body: Data? { nil }
}
