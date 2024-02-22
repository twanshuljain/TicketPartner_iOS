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
    
    enum CreateEvent {
        case selectEventType
        case eventName
        case startDate
        case startTime
        case endDate
        case endTime
        case locationName
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
                return "Location Name*"
            case .streetAddress:
                return "Street Address*"
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
                return "Enter Sate"
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
            }
        }
    }
}
