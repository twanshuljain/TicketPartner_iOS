//
//  ResetPasswordModel.swift
//  TicketSpark
//
//  Created by Apple on 21/02/24.
//

import Foundation

struct ResetPasswordRequest: Codable {
    let newPassword: String?
    let confirmPassword: String?
    var resetToken: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case newPassword = "new_password"
        case confirmPassword = "confirm_password"
        case resetToken = "reset_token"
    }
}
