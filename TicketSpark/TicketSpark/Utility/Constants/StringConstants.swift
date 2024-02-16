//
//  StringConstants.swift
//  TicketSpark
//
//  Created by Apple on 15/02/24.
//

import Foundation
struct StringConstants {
    enum Login {
        case registerNow
        case typeHere
        case forgotPIN
        case loginToNagad
        case enterMobile
        case enterPin
        case mobileNumberError
        case exit
        case downloadQR
        case shareQR
        case myQR
        case loginRegister
        case pinError
        
        var value: String {
            switch self {
            case .registerNow:
                return "registor_now"
            case .typeHere:
                return "Type here"
            case .forgotPIN:
                return "Forgot PIN"
            case .loginToNagad:
                return "Log in to Nagad account"
            case .enterMobile:
                return "Enter mobile number"
            case .enterPin:
                return "Enter pin"
            case .mobileNumberError:
                return "Please input correct mobile number"
            case .exit:
                return "EXIT"
            case .downloadQR:
                return "Download QR"
            case .shareQR:
                return "Share QR"
            case .myQR:
                return "My QR Code"
            case .loginRegister:
                return "LOG IN/REGISTER"
            case .pinError:
                return "Pin Should be 4 or 5 digit long"
            }
        }
    }
    
    enum AddOrganizer {
        case website
        case facebookPage
        case linkdin
        case  twitter
        case organizationName
        case country
        case organizationLogo
        case changeLogo
        case socialNetworkFeeds
        case selectCountry
        case saveAndNext
        case aboutOrganization
        var value: String {
            switch self {
            case .website:
                return "Website"
            case .facebookPage:
                return "Facebook Page"
            case .linkdin:
                return "LinkdIn"
            case .twitter:
                return "Twitter"
            case .organizationName:
                return "Organization Name*"
            case .country:
                return "Country"
            case .organizationLogo:
                return "Organization Logo"
            case .changeLogo:
                return "Change Logo"
            case .socialNetworkFeeds:
                return "Social Network Feeds"
            case .selectCountry:
                return "Select Country"
            case .saveAndNext:
                return "Save and Continue"
            case .aboutOrganization:
                return "Tell us about your Organization"
            }
        }
    }
}
