//
//  ForgotPasswordModel.swift
//  TicketSpark
//
//  Created by Apple on 21/02/24.
//

import Foundation

struct ForgotPasswordRequest: Codable {
    let email: String?
}

// MARK: - DataClass
struct ForgotPasswordResponse: Codable {
    var resetToken, resetTokenExpiration: String?
    var isVerify: Bool?
    var id, userID: Int?

    enum CodingKeys: String, CodingKey {
        case resetToken = "reset_token"
        case resetTokenExpiration = "reset_token_expiration"
        case isVerify = "is_verify"
        case id
        case userID = "user_id"
    }
}
