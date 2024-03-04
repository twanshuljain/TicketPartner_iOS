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
    static let emptyTimezone = "Please select timezone"
    static let emptyLocationName = "Please enter location name"
    static let emptyStreetAddress = "Please enter street address"
    static let emptyCity = "Please enter city"
    static let emptyState = "Please enter state"
    static let emptyCountry = "Please enter country"
    static let emptyEventLink = "Please enter event link"
}
