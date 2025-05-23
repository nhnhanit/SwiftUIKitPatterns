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
    case updatePost(postId: Int, updatePostModel: UpdatePostModel)
    
    var requiresAuthorization: Bool {
        switch self {
        case .fetchPosts:
            return false // API public dont need accessToken
        case .deletePost, .updatePost:
            return true
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
        case .updatePost(let postId, _):
            return "/posts/\(postId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchPosts:
            return .get
        case .deletePost:
            return .delete
        case .updatePost:
            return .patch
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
        default:
            return nil
        }}
    
    var body: Data? {
        switch self {
        case let .updatePost(_, updatePostModel):
            return try? JSONEncoder().encode(updatePostModel)
        default:
            return nil
        }
    }
}
