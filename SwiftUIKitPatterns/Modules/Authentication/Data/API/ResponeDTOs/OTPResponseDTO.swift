//
//  OTPResponseDTO.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 20/5/25.
//

struct OTPResponseDTO: Decodable {
    let phone: String
    let id: Int
}

extension OTPResponseDTO {
    func toDomain() -> OTPResponse {
        OTPResponse(phone: self.phone)
    }
}
