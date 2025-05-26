//
//  Post.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 22/5/25.
//

import Foundation

// Struct Post presentation for a "post" on Domain Layer
// It dont depend on any frameworks or libraies (UIKit, SwiftUI)
struct Post: Codable, Equatable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
    var isFavorite: Bool

    enum CodingKeys: String, CodingKey {
        case id, userId, title, body, isFavorite
    }

    // decode from api response data
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        userId = try container.decode(Int.self, forKey: .userId)
        title = try container.decode(String.self, forKey: .title)
        body = try container.decode(String.self, forKey: .body)
        isFavorite = try container.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false // if it is not exist in the response then it is "false" value
    }

    // encode 
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(userId, forKey: .userId)
        try container.encode(title, forKey: .title)
        try container.encode(body, forKey: .body)
        try container.encode(isFavorite, forKey: .isFavorite)
    }
}
