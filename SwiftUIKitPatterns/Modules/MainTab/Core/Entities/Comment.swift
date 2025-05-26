//
//  Comment.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 26/5/25.
//

import Foundation

struct Comment: Codable, Equatable {
    let id: Int
    let postId: Int
    let body: String
    let name: String
    let email: String

    enum CodingKeys: String, CodingKey {
        case id, postId, body, name, email
    }

    // decode from api response data
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        postId = try container.decode(Int.self, forKey: .postId)
        body = try container.decode(String.self, forKey: .body)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)

    }

}
