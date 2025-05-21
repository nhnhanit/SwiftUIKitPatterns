//
//  AuthorizedRequestBuilder.swift
//  SwiftUI_0325
//
//  Created by hongnhan on 22/4/25.
//

protocol AuthorizedRequestBuilder {
    var requiresAuthorization: Bool { get }
    func authorizedHeaders(baseHeaders: [String: String]?) -> [String: String]
}

extension AuthorizedRequestBuilder {
    func authorizedHeaders(baseHeaders: [String: String]?) -> [String: String] {
        var headers = baseHeaders ?? [:]
        if requiresAuthorization,
           let token = SessionManager.shared.accessToken {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }
}
