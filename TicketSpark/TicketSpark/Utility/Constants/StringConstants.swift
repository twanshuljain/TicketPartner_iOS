//
//  StringConstants.swift
//  TicketSpark
//
//  Created by Apple on 15/02/24.
//

import Foundation
struct StringConstants {
    enum Login {
        case enterOTP
        case otpNotReceived
        
        var value: String {
            switch self {
            case .enterOTP:
                return "Please enter otp"
            case .otpNotReceived:
                return "Not received yet? Resend"
            }
        }
    }
}
