//
//  CreateAccountModel.swift
//  TicketSpark
//
//  Created by Apple on 19/02/24.
//

import Foundation

enum OTPVerify {
    case email
    case number
}

struct SignUpRequest: Codable {
    var firstName, lastName, password, email, mobileNumber, strDialCountryCode: String?
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case password
        case email
        case mobileNumber = "mobile_number"
        case strDialCountryCode = "country_code"
        
    }
}

struct SignUpForNumberRequest: Codable {
    let cellphone: String?
    let countryCode: String?
    
    enum CodingKeys: String, CodingKey {
        case cellphone = "mobile_number"
        case countryCode = "country_code"
    }
}

struct SignUpForEmailOTPRequest: Codable {
    let email: String?
    var otp : String?
    enum CodingKeys: String, CodingKey {
        case email
        case otp
    }
}

struct SignUpForMobileOTPRequest: Codable {
    let cellphone: String?
    let countryCode: String?
    var otp : String?
    enum CodingKeys: String, CodingKey {
        case cellphone = "mobile_number"
        case countryCode = "country_code"
        case otp
    }
}

struct SignUpNumberWithEmailRequest: Codable {
    let email: String?
}
