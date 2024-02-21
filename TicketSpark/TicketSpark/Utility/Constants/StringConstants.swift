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
    
    enum ForgotPassword {
        case reset
        case continueTitle
        case sendLinkSuccess
        
        var value: String {
            switch self {
            case .reset:
                return "Reset"
            case .continueTitle:
                return "Continue"
            case .sendLinkSuccess:
                return "Your reset password link has been sent to your registered email address. Please check your email."
            }
        }
    }
}

struct ImageConstants {
    enum Image {
        case imgEyeOpen
        case imgEyeHide
        case imgError
        case imgRadioSelected
        case imgRadioUnselected
        case imgCheckboxSelected
        case imgCheckboxUnselected
        case imgLogo
        case imgNavStar
        
        var value: String {
            switch self {
            case .imgEyeOpen:
                return "imgEyeOpen"
            case .imgEyeHide:
                return "imgEyeHide"
            case .imgError:
                return "imgError"
            case .imgRadioSelected:
                return "imgRadioSelected"
            case .imgRadioUnselected:
                return "imgRadioUnselected"
            case .imgCheckboxSelected:
                return "imgCheckboxSelected"
            case .imgCheckboxUnselected:
                return "imgCheckboxUnselected"
            case .imgLogo:
                return "img_logo"
            case .imgNavStar:
                return "img_nav_star"
            }
        }
    }
}


enum Storyboard: String {
    case main = "Main"
    case createEvent = "CreateEvent"
    case session = "Session"
    case addOrganizerTab =  "AddOrganizerTab"
    case organization = "Organization"
}

enum StoryboardIdentifier: String {
    //Session
    case SplashViewController
    case LoginViewController
    case SignUpViewController
    case CreateAccountViewController
    case ForgotPasswordViewController
    case ResetPasswordViewController
    case RSCountryPickerController
}
