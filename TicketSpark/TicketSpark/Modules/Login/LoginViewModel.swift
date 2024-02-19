//
//  LoginViewModel.swift
//  TicketSpark
//
//  Created by Apple on 09/02/24.
//

import Foundation


typealias LoginDataCompletion = (Bool,SignInAuthModel?,String?)->Void
typealias LoginSendOTPCompletion = (Bool,SignInAuthModel?,String?)->Void

class LoginViewModel {
    
    // MARK: - VARIABLES
    var strCountryDialCode: String = "+91"
    var strCountryCode: String = "IN"
    var strCountryName: String = "India"
    var otp: String = ""
    var countriesModel = [CountryInfo]()
    var countries = [[String: String]]()
    var emailSignInTop = 275.0
    var mobileSignInTop = 210.0
    var timerShown = true
}

// MARK: - FUNCTIONS
extension LoginViewModel {
    public func validateLogin(_ email:String,
                              _ password:String,
                              _ mobileNumber:String,
                              _ otp:String,
                              _ isEmailViewSelected:Bool) -> (String,Bool) {
        if isEmailViewSelected {
            if Validation.shared.textValidation(text: email, validationType: .email).0 {
                let errMsg = Validation.shared.textValidation(text: email, validationType: .email).1
                return (errMsg, false)
            }
            if Validation.shared.textValidation(text: password, validationType: .password).0 {
                let errMsg = Validation.shared.textValidation(text: password, validationType: .password).1
                return (errMsg, false)
            }
        } else {
            if Validation.shared.textValidation(text: mobileNumber, validationType: .number).0 {
                let errMsg = Validation.shared.textValidation(text: mobileNumber, validationType: .number).1
                return (errMsg, false)
            }
            
            if Validation.shared.textValidation(text: otp, validationType: .otp).0 {
                let errMsg = Validation.shared.textValidation(text: password, validationType: .otp).1
                return (errMsg, false)
            }
        }
        return ("", true)
    }
    
    func signInAPI(_ email:String,_ password:String,_ mobileNumber:String, _ countryCode:String, _ otp:String, isEmailViewSelected:Bool, complition:@escaping LoginDataCompletion) {
        let paramForEmail = SignInRequest(emailPhone: email, password: password)
        let paramForNumber = SignInForNumberRequest(cellphone: mobileNumber, countryCode: self.strCountryDialCode, otp: "")
        
        if isEmailViewSelected == true {
            APIHandler.shared.executeRequestWith(apiName: .SignInEmail, parameters: paramForEmail, methodType: .POST) { (result: Result<ResponseModal<SignInAuthModel>, Error>) in
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
        } else {
            APIHandler.shared.executeRequestWith(apiName: .SignInMobileNumber, parameters: paramForNumber, methodType: .POST) { (result: Result<ResponseModal<SignInAuthModel>, Error>) in
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
    
    func sendOTP(mobileNumber: String, countryCode: String, complition:@escaping LoginSendOTPCompletion) {
        let param = SignInForSendOTPRequest(cellphone: mobileNumber, countryCode: countryCode)
        
        APIHandler.shared.executeRequestWith(apiName: .SignInSendOTP, parameters: param, methodType: .POST) { (result: Result<ResponseModal<SignInAuthModel>, Error>) in
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
