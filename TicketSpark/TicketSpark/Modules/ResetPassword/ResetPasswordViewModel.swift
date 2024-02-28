//
//  ResetPasswordViewModel.swift
//  TicketSpark
//
//  Created by Apple on 21/02/24.
//

import Foundation
import UIKit

class ResetPasswordViewModel {
    // MARK: - VARIABLES
    let popOverView = PopOverView()
    let window = UIApplication.shared.keyWindow!
    var resetPasswordRequest:ResetPasswordRequest?
}
// MARK: - FUNCTIONS
extension ResetPasswordViewModel {
    public func validateFields (_ newPassword:String, _ confirmPassword:String) -> (String,Bool) {
        if Validation.shared.resetPasswordValidation(newPassword: newPassword, confirmPassword: confirmPassword, validationType: .password).0 {
            let errMsg = Validation.shared.resetPasswordValidation(newPassword: newPassword, confirmPassword: confirmPassword, validationType: .password).1
            return (errMsg, false)
        } else if Validation.shared.resetPasswordValidation(newPassword: newPassword, confirmPassword: confirmPassword, validationType: .confirmPassword).0 {
            let errMsg = Validation.shared.resetPasswordValidation(newPassword: newPassword, confirmPassword: confirmPassword, validationType: .confirmPassword).1
            return (errMsg, false)
        }
        return("", true)
    }
    
    func resetPasswordAPI(_ newPassword:String, _ confirmPassword:String, resetToken:String, complition:@escaping LoginDataCompletion) {
        let param = ResetPasswordRequest(newPassword: newPassword, confirmPassword: confirmPassword)
        APIHandler.shared.executeRequestWith(apiName: .ResetPasswordLink, parameters: param, methodType: .POST, resetTokenKey: true , resetKey:  resetToken) { (result: Result<ResponseModal<SignInAuthModel>, Error>) in
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
