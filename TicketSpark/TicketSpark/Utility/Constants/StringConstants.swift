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
        case invalidOTP
        
        var value: String {
            switch self {
            case .enterOTP:
                return "Please enter otp"
            case .otpNotReceived:
                return "Not received yet? Resend"
            case .invalidOTP:
                return "Invalid OTP"
            }
        }
    }
    
    enum ForgotPassword {
        case reset
        case continueTitle
        case sendLinkSuccess
        case invalidOTP
        
        var value: String {
            switch self {
            case .reset:
                return "Reset"
            case .continueTitle:
                return "Continue"
            case .sendLinkSuccess:
                return "Your reset password link has been sent to your registered email address. Please check your email."
            case .invalidOTP:
                return "Invalid OTP. Please try again"
            }
        }
    }
    
    enum AddOrganizer {
        case website
        case facebookPage
        case instagram
        case twitter
        case organizationName
        case country
        case organizationLogo
        case changeLogo
        case socialNetworkFeeds
        case selectCountry
        case saveAndNext
        case aboutOrganization
        case next
        case emptyWebsite
       
        var value: String {
            switch self {
            case .website:
                return "Website"
            case .facebookPage:
                return "Facebook Page"
            case .instagram:
                return "Instagram"
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
            case .next:
                return "Next"
            case .emptyWebsite:
                return "Please enter website url"
            
            }
        }
    }
    
    enum CreateEvent {
        case selectEventType
        case eventName
        case startDate
        case startTime
        case endDate
        case endTime
        case locationName
        case location
        case streetAddress
        case city
        case enterLocation
        case enterStreetAddress
        case enterCity
        case state
        case country
        case saveAndContinue
        case enterState
        case enterCountry
        case eventType
        case description
        case timeZone
        case ticketName
        case quantity
        case price
        case fees
        case buyerPrice
        case revenuePerTicket
        case dateTime
        case ticketStartEnd
        case advanceSettings
        case ticketPerOrder
        case ticketPerUser
        case ticketVisibilty
        case createTicket
        case minimum
        case maximum
        case enterTicketPerUser
        case edit
        case delete
        case eventLink
        case joinEvent
        case selectTimeZone
        case coverImage
        case eventDate
        case eventDoorDate
       var value: String {
            switch self {
            case .selectEventType:
                return "Select event type"
            case .eventName:
                return "Event Name"
            case .startDate:
                return "Start Date"
            case .startTime:
                return "Start Time"
            case .endDate:
                return "End Date"
            case .endTime:
                return "End Time"
            case .locationName:
                return "Location Name"
            case .location:
                return "Location*"
            case .streetAddress:
                return "Street Address"
            case .city:
                return "City*"
            case .enterLocation:
                return "Enter Location"
            case .enterStreetAddress:
                return "Enter street Address"
            case .enterCity:
                return "Enter city"
            case .state:
                return "State*"
            case .country:
                return "Country*"
            case .saveAndContinue:
                return "Save & Continue"
            case .enterState:
                return "Enter State"
            case .enterCountry:
                return "Enter Country"
            case .eventType:
                return "Event Type*"
            case .description:
                return "Description"
            case .timeZone:
                return "Timezone*"
            case .ticketName:
                return "Ticket Name"
            case .quantity:
                return "Quantity*"
            case .price:
                return "Price*"
            case .fees:
                return "Fees*"
            case .buyerPrice:
                return "Buyer price"
            case .revenuePerTicket:
                return "Revenue per ticket"
            case .dateTime:
                return "Date / Time"
            case .ticketStartEnd:
                return "Ticker Start & End"
            case .advanceSettings:
                return "Advance Settings"
            case .ticketPerOrder:
                return "Tickets per order*"
            case .ticketPerUser:
                return "Ticket per user"
            case .ticketVisibilty:
                return "Ticket Visibility*"
            case .createTicket:
                return "Create Ticket"
            case .minimum:
                return "Minimum"
            case .maximum:
                return "Maximum"
            case .enterTicketPerUser:
                return "Enter ticket per user"
            case .edit:
                return "Edit"
            case .delete:
                return "Delete"
            case .eventLink:
                return "Enter event link"
            case .joinEvent:
                return "Link to join the event*"
            case .selectTimeZone:
                return "Select time zone"
            case .coverImage:
                return "Event Cover*"
            case .eventDate:
                return "Event Start & End*"
            case .eventDoorDate:
                return "Door open at*"
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
    
    
    //Organization
    case DashboardTabBarController
}
