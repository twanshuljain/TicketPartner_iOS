//
//  ValidationConstantStrings.swift
//  TicketSpark
//
//  Created by Apple on 15/02/24.
//

import Foundation
import UIKit

class ValidationConstantStrings: NSObject {
    // MARK: - Validation Alert messages
    static let emptyEmail = Bundle.main.localizedString(forKey: "Please enter your email address", value: "", table: nil)
    static let emptyNumber = "Please enter mobile number"
    static let invalidNumber = "Please enter valid mobile number"
    static let emptyName = "Please enter full name"
    static let emptyFirstName = "Please enter first name"
    static let emptyLastName = "Please enter last name"
    static let invalidName = "Please enter valid full name"
    static let invalidFirstName = "Please enter valid first name"
    static let invalidLastName = "Please enter valid last name"
    static let invalidEmail = "The user email must be a valid email address"
    static let emailInvalid = "The email must be a valid email"
    static let emailNotMatched = "Email and confirm email will be same"
    static let passwordNotMatch = "Password and confirm password are not same"
    static let emptyOtp = "OTP is required"
    static let invalidOtp = "Please enter a valid OTP"
    static let emptyPassword = "Please enter password"
    static let emptyNewPassword = "New password is required"
    static let invalidPassword = "Please enter valid password"
    static let invalidNewPassword = "Please enter valid new password"
    static let invalidConfirmNewPassword = "New password and confirm password doesn't match"
    static let emptyCurrentPassword = "Current password is required"
    static let emptyConfirmPassword = "Confirm password is required"
    static let invalidCurrentPassword = "Please enter valid current password"
    static let invalidConfirmPassword = "Please enter valid confirm password"
    static let invalidCurrentPasswordMatch = "Current password and new password are not same"
    static let networkLost = "Check Network Availibilty"
    static let passwordValidationMessage = "Password must have at least 8 characters including 1 uppercase and 1 lowercase letter, 1 digit, and 1 special character"
    static let confirmPasswordValidationMessage = "Confirm Password must have at least 8 characters including 1 uppercase and 1 lowercase letter, 1 digit, and 1 special character"
    
    //ORGANISATION
    static let organizationName = "Please enter organization name"
    static let organizationCountry = "Please select country"
    static let organizationImage = "Please select logo"
    
   //Create Event
    static let emptyEventName = "Please enter event name"
    static let selectEventType = "Please select event type"
    static let selectEventType1 = "Select event type"
    static let emptDesc = "Please enter description"
    static let emptyCoverImage = "Please select cover image"
    static let emptyTimezone = "Please select timezone"
    static let selectStartDate = "Please select start date"
    static let selectEndDate = "Please select end date"
    static let selectStartTime = "Please select start time"
    static let selectEndTime = "Please select end time"
    static let selectDoorOpenDate = "Please select door open date"
    static let selectDoorCloseDate = "Please select door close date"
    static let selectDoorOpenTime = "Please select door open time"
    static let selectDoorCloseTime = "Please select door close time"
    
    static let emptyLocationName = "Please enter location name"
    static let emptyStreetAddress = "Please enter street address"
    static let emptyCity = "Please enter city"
    static let emptyState = "Please enter state"
    static let emptyCountry = "Please enter country"
    static let emptyEventLink = "Please enter event link"
    
    static let emptyTicketName = "Please enter ticket name "
    static let emptyTicketQuantity = "Please enter ticket quantity "
    static let ticketQuantityZero = "Quantity must be greater than 0 "
    static let ticketQuantityExceed = "Quantity must be less than or equal to 50000 "
    static let emptyTicketPrice = "Please enter ticket price "
    static let ticketPriceZero = "Price must be greater than 0 "
    static let emptyTicketStartDate = "Please select ticket start date "
    static let emptyTicketEndDate = "Please select ticket end date "
    static let emptyTicketStartTime = "Please select ticket start time "
    static let emptyTicketEndTime = "Please select ticket end time "
    static let emptyTicketVisibility = "Please select ticket visibility "
    static let emptyTicketAdmissionPerTicket = "Please enter admission per ticket "
    static let ticketAdmissionPerTicketZero = "Admission per ticket quantity must be greater than 0 "
    static let emptyTicketTimeZone = "Please select time zone "
    static let emptyTicketAmountType = "Please select amount type "
    
    
    
}
