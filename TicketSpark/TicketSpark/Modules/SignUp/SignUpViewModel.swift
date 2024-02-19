//
//  SignUpViewModel.swift
//  TicketSpark
//
//  Created by Apple on 15/02/24.
//

import Foundation

class SignUpViewModel {
    
}

//MARK: - FUNCTIONS
extension SignUpViewModel {
    //Register
    public func validateFields (_ emailAddress:String) -> (String,Bool) {
        if Validation.shared.textValidation(text: emailAddress, validationType: .email).0 {
            let errMsg = Validation.shared.textValidation(text: emailAddress, validationType: .email).1
            return (errMsg, false)
        }
        return("", true)
    }
}
