//
//  LoginModel.swift
//  TicketSpark
//
//  Created by Apple on 09/02/24.
//

import Foundation


struct SignInAuthModel: Codable {
    var id: Int?
    var number: String?
    var firstName, lastName, email, accessToken, refreshToken, strDialCountryCode, image, userStatus, userType, password: String?
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case number = "mobile_number"
        case strDialCountryCode = "country_code"
        case image
        case userStatus = "user_status"
        case userType = "user_type"
        case password
    }
}

struct SignInRequest: Codable {
    let emailPhone: String?
    let password: String?
    enum CodingKeys: String, CodingKey {
        case emailPhone = "email"
        case password = "password"
    }
}
struct SignInForNumberRequest: Codable {
    let cellphone: String?
    let countryCode: String?
    let otp: String?
    enum CodingKeys: String, CodingKey {
        case cellphone = "mobile_number"
        case countryCode = "country_code"
        case otp
    }
}

struct SignInForSendOTPRequest: Codable {
    let cellphone: String?
    let countryCode: String?
    enum CodingKeys: String, CodingKey {
        case cellphone = "mobile_number"
        case countryCode = "country_code"
    }
}

struct SignInNumberWithEmailRequest: Codable {
    let email: String?
}


struct ValidateForNumberRequest: Encodable {
    var cellPhone: String?
    var email: String?
    var countryCode: String?
    var firstName: String?
    var lastName: String?
    
    enum CodingKeys: String, CodingKey {
        case cellPhone = "cell_phone"
        case email
        case countryCode = "country_code"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
