//
//  Post.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 22/5/25.
//

import Foundation

// Struct Post đại diện cho một bài viết trong Domain Layer
// Không phụ thuộc vào bất kỳ framework hay thư viện nào khác
struct Post: Codable, Equatable { // Equatable để dễ dàng so sánh trong test
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
