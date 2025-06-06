//
//  VerifyOTPResponseDTO.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 19/5/25.
//

struct VerifyOTPResponseDTO: Decodable {
    let phone: String
    let id: Int
}

extension VerifyOTPResponseDTO {
    func toDomain() -> VerifyOtp {
        VerifyOtp(phone: self.phone)
    }
}
