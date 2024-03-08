//
//  Validation.swift
//  TicketSpark
//
//  Created by Apple on 15/02/24.
//

import Foundation
import UIKit

//MARK: - InputValidation
enum InputValidation: String {
    case email
    case otp
    case firstname
    case lastname
    case name
    case number
    case password
    case description
    case signUpPassword
    case signUpConfirmPassword
    case confirmPassword
    case organizationName
    case organizationCountry
    case organizationImage
    case eventName
    case eventType
    case desc
    case timezone
    case startDate
    case endDate
    case startTime
    case endTime
    case doorOpenDate
    case doorCloseDate
    case doorOpenTime
    case doorCloseTime
    case locationName
    case streetAddress
    case city
    case state
    case country
    case eventLink
}
enum ValidationType: String {
    case reqName = "reqName"
    case reqFullname = "reqFullName"
    case reqFirstname = "reqFirstName"
    case reqLastname = "reqLastName"
    case reqEmail = "reqEmail"
    case reqPassword = "reqPassword"
    case reqConfirmPass = "reqConfirmPass"
    case reqMobile = "reqMobile"
    case validEmail = "validEmail"
    case validPassword = "validPassword"
    case validMobile = "validMobile"
    case validUrl = "validUrl"
    case compareField = "compareField"
    case containWhiteSpace = "space"
    case reqDob = "reqDob"
}

enum InputCompareValidation: String {
    case email
    case password
}
//MARK: - Validation
class Validation {
    static let shared = Validation()
    private init() { }
    // swiftlint:disable empty_count
    public typealias ValidationParam = [ValidationType: (priority: Int, fieldToValidate: UITextField)]
    func textValidation(text: String, validationType: InputValidation) -> (Bool, String) {
        switch validationType {
        case .email:
            return(
                text.isEmpty ? true: Validation.shared.isValidEmail(emaiId: text) == false ? true: false,
                text.isEmpty ? ValidationConstantStrings.emptyEmail:ValidationConstantStrings.invalidEmail)
        case .number:
            return(
                text.isEmpty ? true:
                    text.count < 10 ? true : false,
                text.isEmpty ? ValidationConstantStrings.emptyNumber:ValidationConstantStrings.invalidNumber)
        case .password:
            return(
                text.isEmpty ? true :
                    text.count < 4 ? true : false,
                text.isEmpty ? ValidationConstantStrings.emptyPassword : ValidationConstantStrings.invalidPassword)
        case .signUpPassword:
            return(
                text.isEmpty ? true :
                    text.isValidPasswords(password: text) ? false : true,
                text.isEmpty ? ValidationConstantStrings.emptyPassword : ValidationConstantStrings.passwordValidationMessage
            )
        case .signUpConfirmPassword:
            return(
                text.isEmpty ? true :
                    text.isValidPasswords(password: text) ? false : true,
                text.isEmpty ? ValidationConstantStrings.emptyPassword : ValidationConstantStrings.confirmPasswordValidationMessage
            )
        case .confirmPassword:
            return(
                text.isEmpty ? true :
                    text.count < 8 ? true : false,
                text.isEmpty ? ValidationConstantStrings.emptyConfirmPassword : ValidationConstantStrings.invalidPassword)
        case .name:
            return( text.isEmpty ? true :
                        text.count < 2 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.emptyName : ValidationConstantStrings.invalidName)
        case .description:
            return( text.isEmpty ? true :
                        text.count > 140 ? true : false,
                    text.isEmpty ? "AppConstant.emptyDescription": "AppConstant.invalidDescription")
        case .otp:
            return(text.isEmpty ? true :
                    text.count < 4 ? true : false,
                   text.isEmpty ? ValidationConstantStrings.emptyOtp : ValidationConstantStrings.invalidOtp)
        case .firstname:
            return( text.isEmpty ? true :
                        text.count < 2 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.emptyFirstName : ValidationConstantStrings.invalidFirstName)
        case .lastname:
            return( text.isEmpty ? true :
                        text.count < 2 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.emptyLastName : ValidationConstantStrings.invalidLastName)
        case .organizationName:
            return( text.isEmpty ? true :
                        text.count < 1 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.organizationName : ValidationConstantStrings.organizationName)
        case .organizationCountry:
            return( text.isEmpty ? true :
                        text.count < 1 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.organizationCountry : ValidationConstantStrings.organizationCountry)
        case .organizationImage:
            return (true, "")
        case .eventName, .eventType, .desc, .timezone, .locationName, .streetAddress, .city, .state, .country, .eventLink, .startDate, .endDate, .startTime, .endTime, .doorOpenDate, .doorCloseDate, .doorOpenTime, .doorCloseTime:
            return (true, "")
        }
    }
    
    func resetPasswordValidation(newPassword: String, confirmPassword: String, validationType: InputValidation) -> (Bool, String) {
        switch validationType {
        case .password:
            return(
                newPassword.isEmpty ? true :
                    newPassword.count < 4 ? true : false,
                newPassword.isEmpty ? ValidationConstantStrings.emptyPassword : ValidationConstantStrings.invalidPassword)
        case .confirmPassword:
            return(
                confirmPassword.isEmpty ? true :
                    newPassword != confirmPassword ? true : false,
                confirmPassword.isEmpty ? ValidationConstantStrings.emptyConfirmPassword : ValidationConstantStrings.invalidConfirmNewPassword)
        
        case .email,.otp,.firstname,.lastname,.name,.number,.description,.signUpPassword,.signUpConfirmPassword, .organizationName, .organizationCountry, .organizationImage:
            break;
        case .eventName, .eventType, .desc, .timezone, .locationName, .streetAddress, .city, .state, .country, .eventLink, .startDate, .endDate, .startTime, .endTime, .doorOpenDate, .doorCloseDate, .doorOpenTime, .doorCloseTime:
            break;
        }
        return (true,"")
    }
    
    func createEventBasicValidation(text: String, validationType: InputValidation) -> (Bool, String) {
        switch validationType {
        case .eventName:
            return(text.isEmpty ? true :
                        text.count < 1 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.emptyEventName : ValidationConstantStrings.emptyEventName)
        case .eventType:
            return(text.isEmpty ? true :
                        text != ValidationConstantStrings.selectEventType1 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.selectEventType : ValidationConstantStrings.selectEventType)
        case .desc:
            return(text.isEmpty ? true :
                        text.count < 1 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.emptDesc : ValidationConstantStrings.emptDesc)
        case .timezone:
            return(text.isEmpty ? true :
                        text.count < 1 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.emptyTimezone : ValidationConstantStrings.emptyTimezone)
        case .locationName:
            return(text.isEmpty ? true :
                        text.count < 1 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.emptyLocationName : ValidationConstantStrings.emptyLocationName)
        case .streetAddress:
            return(text.isEmpty ? true :
                        text.count < 1 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.emptyStreetAddress : ValidationConstantStrings.emptyStreetAddress)
        case .city:
            return(text.isEmpty ? true :
                        text.count < 1 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.emptyCity : ValidationConstantStrings.emptyCity)
        case .state:
            return(text.isEmpty ? true :
                        text.count < 1 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.emptyState : ValidationConstantStrings.emptyState)
        case .country:
            return(text.isEmpty ? true :
                        text.count < 1 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.emptyCountry : ValidationConstantStrings.emptyCountry)
        case .eventLink:
            return(text.isEmpty ? true :
                        text.count < 1 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.emptyEventLink : ValidationConstantStrings.emptyEventLink)
        case .password, .confirmPassword, .email,.otp,.firstname,.lastname,.name,.number,.description,.signUpPassword,.signUpConfirmPassword, .organizationName, .organizationCountry, .organizationImage:
            break;
        case .startDate:
            return(text.isEmpty ? true :
                        text.count < 1 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.selectStartDate : ValidationConstantStrings.selectStartDate)
        case .endDate:
            return(text.isEmpty ? true :
                        text.count < 1 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.selectEndDate : ValidationConstantStrings.selectEndDate)
        case .startTime:
            return(text.isEmpty ? true :
                        text.count < 1 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.selectStartTime : ValidationConstantStrings.selectStartTime)
        case .endTime:
            return(text.isEmpty ? true :
                        text.count < 1 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.selectEndTime : ValidationConstantStrings.selectEndTime)
        case .doorOpenDate:
            return(text.isEmpty ? true :
                        text.count < 1 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.selectDoorOpenDate : ValidationConstantStrings.selectDoorOpenDate)
        case .doorCloseDate:
            return(text.isEmpty ? true :
                        text.count < 1 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.selectDoorCloseDate : ValidationConstantStrings.selectDoorCloseDate)
        case .doorOpenTime:
            return(text.isEmpty ? true :
                        text.count < 1 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.selectDoorOpenTime : ValidationConstantStrings.selectDoorOpenTime)
        case .doorCloseTime:
            return(text.isEmpty ? true :
                        text.count < 1 ? true : false,
                    text.isEmpty ? ValidationConstantStrings.selectDoorCloseTime : ValidationConstantStrings.selectDoorCloseTime)
        }
        return (true,"")
    }
    
    func CompareValidation(fieldName: ValidationParam, compare: (CompareField: UITextField, CompareFieldTo: UITextField)? = nil) -> (Bool, String) {
        var valuess = fieldName.sorted(by: { (arg0, arg1) -> Bool in
            return arg0.value.priority < arg1.value.priority
        })
        if compare != nil {
            valuess.append((key: .compareField, value: (valuess.count + 1, compare?.CompareField ?? UITextField())))
        }
        for (key: valType, value: (priority: _, fieldToValidate: txtField)) in valuess {
            switch valType {
            case .reqName:
                if txtField.text?.trim() == "" {
                    txtField.becomeFirstResponder()
                    return (false, "Invalid Name")
                }
            case .reqFullname:
                if txtField.text?.trim() == "" {
                    txtField.becomeFirstResponder()
                    return (false, "Invalid Full Name")
                }
            case .reqFirstname:
                if txtField.text?.trim() == "" {
                    txtField.becomeFirstResponder()
                    return (false, "Invalid First Name")
                }
            case .reqLastname:
                if txtField.text?.trim() == "" {
                    txtField.becomeFirstResponder()
                    return (false, "Invalid Last Name")
                }
            case .reqEmail:
                if txtField.text?.trim() == "" {
                    txtField.becomeFirstResponder()
                    return (false, "Invalid Email")
                }
            case .reqPassword:
                if txtField.text?.trim() == "" {
                    txtField.becomeFirstResponder()
                    return (false, "Invalid Password")
                }
            case .reqConfirmPass:
                if txtField.text?.trim() == "" {
                    txtField.becomeFirstResponder()
                    return (false, "Invalid Confirm Password")
                }
            case .reqMobile:
                if txtField.text?.trim() == "" {
                    txtField.becomeFirstResponder()
                    return (false, "Invalid Mobile Number")
                }
            case .validEmail:
                if !ValidationCheckFuncs.isValidEmail(testStr: (txtField.text?.trim())!) {
                    txtField.becomeFirstResponder()
                    return (false, "Invalid Email")
                }
            case .validPassword:
                if txtField.text?.trim().count != 0 {
                    if (txtField.text?.count)! < 6 {
                        return (false, "Invalid Password.")
                    } else if (txtField.text?.count)! > 15 {
                        return (false, "Invalid Password.")
                    }
                }
            case .validMobile:
                if txtField.text?.trim().count != 0 {
                    if (txtField.text?.count)! < 8 {
                        txtField.becomeFirstResponder()
                        return (false, "Invalid Mobile")
                    } else if (txtField.text?.count)! > 15 {
                        txtField.becomeFirstResponder()
                        return (false, "Invalid Mobile")
                    }
                }
            case .compareField:
                if compare?.CompareField.text?.trim() != compare?.CompareFieldTo.text?.trim() {
                    compare?.CompareFieldTo.becomeFirstResponder()
                    return (false, "Invalid Compare filed.")
                }
            case .containWhiteSpace:
                break
            case .validUrl:
                if !ValidationCheckFuncs.isValidateURL(stringURL: txtField.text?.trim() ?? "") {
                    txtField.becomeFirstResponder()
                    return (false, "Invalid URL")
                }
            case .reqDob:
                if txtField.text?.trim() == "" {
                    txtField.becomeFirstResponder()
                    return (false, "Invalid DOB")
                }
            }
        }
        return (true, "")
    }
    func textComparisonValidation(firstText: String,
                                  secondText: String,
                                  validationType: InputCompareValidation) -> (Bool, String) {
        switch validationType {
        case .email:
            return firstText != secondText ? (true, ValidationConstantStrings.emailNotMatched) : (false, "he")
        case .password:
            return firstText != secondText ? (true, ValidationConstantStrings.passwordNotMatch) : (false, "he")
        }
    }
    func isValidEmail(emaiId: String) -> Bool {
        let emailRegEx = NSPredicate(format: "SELF MATCHES %@",
                                     "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailRegEx.evaluate(with: emaiId)
    }
    func isValidname(name: String) -> Bool {
        let nameRegEx = NSPredicate(format: "SELF MATCHES %@",
                                    "^[a-zA-Z]-_")
        return nameRegEx.evaluate(with: name)
    }
    func isValidPhoneNumber(number:String) -> Bool {
        let regEx = "^\\+(?:[0-9]?){6,14}[0-9]$"
        
        let phoneCheck = NSPredicate(format: "SELF MATCHES %@", regEx)
        return phoneCheck.evaluate(with: number)
    }
    // Special Characters Validations
    func isTextContainspecialCharacters(string: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[^a-z0-9 ]", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) {
                return true
            } else {
                return false
            }
        } catch {
            debugPrint(error.localizedDescription)
            return true
        }
    }
}
