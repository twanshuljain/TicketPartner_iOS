//
//  ForgotPasswordViewModel.swift
//  TicketSpark
//
//  Created by Apple on 21/02/24.
//

import Foundation
import UIKit

typealias ForgotPasswordCompletion = (Bool,ForgotPasswordResponse?,String?)->Void

class ForgotPasswordViewModel {
    // MARK: - VARIABLES
    let popOverView = PopOverView()
    let window = UIApplication.shared.keyWindow!
    var resetPasswordRequest:ResetPasswordRequest?
    var otp: String = ""
}
// MARK: - FUNCTIONS
extension ForgotPasswordViewModel {
    public func validateFields (_ emailAddress:String) -> (String,Bool) {
        if Validation.shared.textValidation(text: emailAddress, validationType: .email).0 {
            let errMsg = Validation.shared.textValidation(text: emailAddress, validationType: .email).1
            return (errMsg, false)
        }
        return("", true)
    }
    
//    func sendForgotPasswordLinkAPI(_ email:String, complition:@escaping ForgotPasswordCompletion) {
//        let param = ForgotPasswordRequest(email: email)
//            APIHandler.shared.executeRequestWith(apiName: .ForgotPasswordSendLink, parameters: param, methodType: .POST) { (result: Result<ResponseModal<ForgotPasswordResponse>, Error>) in
//                switch result {
//                case .success(let response):
//                    if response.status_code == 200 {
//                        complition(true, response.data , response.message)
//                    } else {
//                        complition(false,response.data, response.message ?? "error message")
//                    }
//                case .failure(let error):
//                    complition(false, nil, "\(error)")
//                }
//            }
//    }
    
    // API CALL FOR OTP FLOW
//    func sendForgotPasswordLinkAPI(_ email:String, complition:@escaping ForgotPasswordCompletion) {
//        let param = ForgotPasswordRequest(email: email, otp: self.otp)
//            APIHandler.shared.executeRequestWith(apiName: .ForgotPasswordVerifyOTP, parameters: param, methodType: .POST) { (result: Result<ResponseModal<ForgotPasswordResponse>, Error>) in
//                switch result {
//                case .success(let response):
//                    if response.status_code == 200 {
//                        complition(true, response.data , response.message)
//                    } else {
//                        complition(false,response.data, response.message ?? "error message")
//                    }
//                case .failure(let error):
//                    complition(false, nil, "\(error)")
//                }
//            }
//    }
    
    // API CALL FOR SEND LINK
    func sendForgotPasswordLinkAPI(_ email:String, complition:@escaping ForgotPasswordCompletion) {
        let param = ForgotPasswordRequest(email: email, otp: self.otp)
            APIHandler.shared.executeRequestWith(apiName: .ForgotPasswordSendLink, parameters: param, methodType: .POST) { (result: Result<ResponseModal<ForgotPasswordResponse>, Error>) in
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
    
    func sendOTP(_ email:String, complition:@escaping ForgotPasswordCompletion) {
        let param = ForgotPasswordRequest(email: email)
        
        APIHandler.shared.executeRequestWith(apiName: .ForgotPasswordSendEmailOTP, parameters: param, methodType: .POST) { (result: Result<ResponseModal<ForgotPasswordResponse>, Error>) in
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
