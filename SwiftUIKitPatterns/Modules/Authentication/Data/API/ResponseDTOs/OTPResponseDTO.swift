//
//  OTPResponseDTO.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 20/5/25.
//

struct OTPResponseDTO: Decodable {
    let phone: String
    let otpExpiresIn: Int
    let id: Int
}

extension OTPResponseDTO {
    func toDomain() -> Otp {
        Otp(phone: self.phone,
            otpExpiresIn: self.otpExpiresIn)
    }
}
