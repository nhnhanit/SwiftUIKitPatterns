//
//  Post.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 22/5/25.
//

import Foundation

// Struct Post đại diện cho một bài viết trong Domain Layer
// Không phụ thuộc vào bất kỳ framework hay thư viện nào khác
struct Post: Codable, Equatable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
    var isFavorite: Bool // not optional nữa

    enum CodingKeys: String, CodingKey {
        case id, userId, title, body, isFavorite
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        userId = try container.decode(Int.self, forKey: .userId)
        title = try container.decode(String.self, forKey: .title)
        body = try container.decode(String.self, forKey: .body)
        isFavorite = try container.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false
    }

    // Nếu bạn muốn encode nữa:
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(userId, forKey: .userId)
        try container.encode(title, forKey: .title)
        try container.encode(body, forKey: .body)
        try container.encode(isFavorite, forKey: .isFavorite)
    }
}
