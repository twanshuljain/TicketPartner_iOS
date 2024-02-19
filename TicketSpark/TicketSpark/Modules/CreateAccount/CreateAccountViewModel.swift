//
//  CreateAccountViewModel.swift
//  TicketSpark
//
//  Created by Apple on 19/02/24.
//

import Foundation

class CreateAccountViewModel {
    
    // MARK: - VARIABLES
    var signUpRequest:SignUpRequest?
    var countriesModel = [CountryInfo]()
    var countries = [[String: String]]()
    var strCountryDialCode: String = "+91"
    var strCountryCode: String = "IN"
    var strCountryName: String = "India"
    var otpVerify:OTPVerify = .email
}

//MARK: - FUNCTIONS
extension CreateAccountViewModel{
    //Register
    public func validateSignUp (_ fName:String,lName : String,
                                 _ emailAddress:String,
                                 _ password:String,
                                 _ mobileNumber:String,
                                 _ countryCode : String) -> (String,Bool) {
        
        if Validation.shared.textValidation(text: emailAddress, validationType: .email).0 {
            let errMsg = Validation.shared.textValidation(text: emailAddress, validationType: .email).1
            return (errMsg, false)
        }else if Validation.shared.textValidation(text: fName, validationType: .firstname).0 {
            let errMsg = Validation.shared.textValidation(text: fName, validationType: .firstname).1
            return (errMsg, false)
        }else if Validation.shared.textValidation(text: lName, validationType: .lastname).0 {
            let errMsg = Validation.shared.textValidation(text: lName, validationType: .lastname).1
            return (errMsg, false)
        } else if Validation.shared.textValidation(text: mobileNumber, validationType: .number).0 {
            let errMsg = Validation.shared.textValidation(text: mobileNumber, validationType: .number).1
            return (errMsg, false)
        } else if countryCode.isEmpty {
            return ("Please select country", false)
        } else if Validation.shared.textValidation(text: password, validationType: .password).0 {
            let errMsg = Validation.shared.textValidation(text: password, validationType: .password).1
            return (errMsg, false)
        }
        return("", true)
    }
    
    public func validateEmail (_  emailAddress:String) -> (String,Bool) {
        if Validation.shared.textValidation(text: emailAddress, validationType: .email).0 {
            let errMsg = Validation.shared.textValidation(text: emailAddress, validationType: .email).1
            return (errMsg, false)
        }
        return("", true)
    }
    
    public func validateMobile (_  mobileNumber:String) -> (String,Bool) {
        if Validation.shared.textValidation(text: mobileNumber, validationType: .number).0 {
            let errMsg = Validation.shared.textValidation(text: mobileNumber, validationType: .number).1
            return (errMsg, false)
        }
        return("", true)
    }
    
    
    func signUpAPI(_ fName:String, _ lName:String,_ email:String,_ password:String,_ mobileNumber:String, _ countryCode:String, complition:@escaping LoginDataCompletion) {
        let param = SignUpRequest(firstName: fName, lastName: lName, password: password, email: email, mobileNumber: mobileNumber, strDialCountryCode: countryCode)
        
            APIHandler.shared.executeRequestWith(apiName: .SignUp, parameters: param, methodType: .POST) { (result: Result<ResponseModal<SignInAuthModel>, Error>) in
                switch result {
                case .success(let response):
                    if response.status_code == 200 {
                        complition(true, response.data , response.message)
                    } else {
                        complition(false,response.data, response.message ?? "error message")
                    }
                case .failure(let error):
                    complition(false, nil, "\(error)")
                }
            }
    }
    
    func sendEmailOTP(email: String, complition:@escaping LoginSendOTPCompletion) {
        let param = SignUpForEmailOTPRequest(email: email)
        
        APIHandler.shared.executeRequestWith(apiName: .SignUpEmailSendOTP, parameters: param, methodType: .POST) { (result: Result<ResponseModal<SignInAuthModel>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    complition(true, response.data , response.message)
                } else {
                    complition(false,response.data, response.message ?? "error message")
                }
            case .failure(let error):
                complition(false, nil, "\(error)")
            }
        }
    }
    
    func sendMobileOTP(mobileNumber: String, countryCode: String, complition:@escaping LoginSendOTPCompletion) {
        let param = SignUpForMobileOTPRequest(cellphone: mobileNumber, countryCode: countryCode)
        
        APIHandler.shared.executeRequestWith(apiName: .SignUpMobileSendOTP, parameters: param, methodType: .POST) { (result: Result<ResponseModal<SignInAuthModel>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    complition(true, response.data , response.message)
                } else {
                    complition(false,response.data, response.message ?? "error message")
                }
            case .failure(let error):
                complition(false, nil, "\(error)")
            }
        }
    }
    
    func verifyEmailOTP(email: String, otp: String, complition:@escaping LoginSendOTPCompletion) {
        let param = SignUpForEmailOTPRequest(email: email, otp: otp)
        
        APIHandler.shared.executeRequestWith(apiName: .SignUpEmailVerifyOTP, parameters: param, methodType: .POST) { (result: Result<ResponseModal<SignInAuthModel>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    complition(true, response.data , response.message)
                } else {
                    complition(false,response.data, response.message ?? "error message")
                }
            case .failure(let error):
                complition(false, nil, "\(error)")
            }
        }
    }
    
    func verifyMobileOTP(mobileNumber: String, countryCode: String, otp: String, complition:@escaping LoginSendOTPCompletion) {
        let param = SignUpForMobileOTPRequest(cellphone: mobileNumber, countryCode: countryCode, otp: otp)
        
        APIHandler.shared.executeRequestWith(apiName: .SignUpMobileVerifyOTP, parameters: param, methodType: .POST) { (result: Result<ResponseModal<SignInAuthModel>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    complition(true, response.data , response.message)
                } else {
                    complition(false,response.data, response.message ?? "error message")
                }
            case .failure(let error):
                complition(false, nil, "\(error)")
            }
        }
    }
}
