//
//  User.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 26/5/25.
//

import Foundation

struct User: Codable, Equatable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, email, phone
    }
    
    // decode from api response data
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        phone = try container.decode(String.self, forKey: .phone)
    }

}
