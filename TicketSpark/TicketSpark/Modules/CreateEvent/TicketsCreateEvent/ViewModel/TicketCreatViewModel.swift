//
//  TicketCreatViewModel.swift
//  TicketSpark
//
//  Created by Apple on 22/02/24.
//

import Foundation
import UIKit

enum CreateTicketScroll {
    case ticketName
    case ticketQuantity
    case ticketPrice
    case ticketStartDate
    case ticketEndDate
    case ticketStartTime
    case ticketEndTime
    case ticketVisibility
    case ticketAdmissionPerTicket
    case ticketTimeZone
    case ticketAmountType
    case none
}

enum CreateTicketType {
    case paid
    case free
    case group
    case donation
}

typealias GetCreateTicketCompletion = (Bool,CreateTicket?,String?)->Void

struct TicketTypeModel {
    let ticketType: String
    var isSelected: Bool = false
}
class TicketCreateViewModel {
    // MARK: - Variables
    var createTicketRequest = CreateTicketRequest()
    var ticketType: [TicketTypeModel] = []
//    ["Paid Ticket", "Free Ticket", "Group", "Donation"]
    var numberOfRow: Int {
        return ticketType.count
    }
    var createTicketType:CreateTicketType = .paid
    init() {
        appendTicketType()
    }
}
// MARK: - Functions
extension TicketCreateViewModel {
    func getItems(at index: Int) -> TicketTypeModel {
        return ticketType[index]
    }
    
    func appendTicketType() {
        var paid = TicketTypeModel(ticketType: "Paid Ticket")
        let freeTicket = TicketTypeModel(ticketType: "Free Ticket")
        let group = TicketTypeModel(ticketType: "Group")
        let donation = TicketTypeModel(ticketType: "Donation")
        paid.isSelected = true
        ticketType.append(paid)
        ticketType.append(freeTicket)
        ticketType.append(group)
        ticketType.append(donation)
        
    }
    
    // Function to scroll the UIScrollView to the position of the UITextField
    func scrollToTextField(_ textField: UIView, scrollView: UIScrollView) {
        let rect = textField.convert(textField.bounds, to: scrollView)
        scrollView.scrollRectToVisible(rect, animated: true)
    }
    
    func validateFields (_ createTicketRequest: CreateTicketRequest) -> (String,Bool,CreateTicketScroll) {
        if Validation.shared.createTicketValidation(text: createTicketRequest.ticketName ?? "", validationType: .ticketName).0 {
            let errMsg = Validation.shared.createTicketValidation(text: createTicketRequest.ticketName ?? "", validationType: .ticketName).1
            return (errMsg, false, .ticketName)
        } else if createTicketRequest.ticketQuantity == nil || createTicketRequest.ticketQuantity == 0 {
            if let quantity = createTicketRequest.ticketQuantity {
                let boolValue = Validation.shared.createTicketValidation(text: "\(quantity)", validationType: .ticketQuantity).0
                let errMsg = Validation.shared.createTicketValidation(text: "\(quantity)", validationType: .ticketQuantity).1
                return (errMsg, boolValue, .ticketQuantity)
            }
            let boolValue = Validation.shared.createTicketValidation(text: "", validationType: .ticketQuantity).0
            let errMsg = Validation.shared.createTicketValidation(text: "", validationType: .ticketQuantity).1
            return (errMsg, boolValue, .ticketQuantity)
            
        } else if createTicketRequest.ticketPrice == nil && self.createTicketType != .free || createTicketRequest.ticketPrice == 0   {
            if let ticketPrice = createTicketRequest.ticketPrice {
                let boolValue = Validation.shared.createTicketValidation(text: "\(ticketPrice)", validationType: .ticketPrice).0
                let errMsg = Validation.shared.createTicketValidation(text: "\(ticketPrice)", validationType: .ticketPrice).1
                return (errMsg, boolValue, .ticketPrice)
            }
            let boolValue = Validation.shared.createTicketValidation(text: "", validationType: .ticketPrice).0
            let errMsg = Validation.shared.createTicketValidation(text: "", validationType: .ticketPrice).1
            return (errMsg, boolValue, .ticketPrice)
            
        } else if Validation.shared.createTicketValidation(text: createTicketRequest.ticketSaleStartDate ?? "", validationType: .ticketStartDate).0 {
            let errMsg = Validation.shared.createTicketValidation(text: createTicketRequest.ticketSaleStartDate ?? "", validationType: .ticketStartDate).1
            return (errMsg, false, .ticketStartDate)
        } else if Validation.shared.createTicketValidation(text: createTicketRequest.ticketSaleEndDate ?? "", validationType: .ticketEndDate).0 {
            let errMsg = Validation.shared.createTicketValidation(text: createTicketRequest.ticketSaleEndDate ?? "", validationType: .ticketEndDate).1
            return (errMsg, false, .ticketEndDate)
        } else if Validation.shared.createTicketValidation(text: createTicketRequest.ticketSaleStartTime ?? "", validationType: .ticketStartTime).0 {
            let errMsg = Validation.shared.createTicketValidation(text: createTicketRequest.ticketSaleStartTime ?? "", validationType: .ticketStartTime).1
            return (errMsg, false, .ticketStartTime)
        } else if Validation.shared.createTicketValidation(text: createTicketRequest.ticketSaleEndTime ?? "", validationType: .ticketEndTime).0 {
            let errMsg = Validation.shared.createTicketValidation(text: createTicketRequest.ticketSaleEndTime ?? "", validationType: .ticketEndTime).1
            return (errMsg, false, .ticketEndTime)
        } else if createTicketRequest.ticketVisibility?.isEmpty ?? false {
            let boolValue = Validation.shared.createTicketValidation(text: createTicketRequest.ticketVisibility ?? "", validationType: .ticketVisibility).0
            let errMsg = Validation.shared.createTicketValidation(text: createTicketRequest.ticketVisibility ?? "", validationType: .ticketVisibility).1
            return (errMsg, boolValue, .ticketVisibility)
        } else if createTicketRequest.oneTicketEqualTo == nil && self.createTicketType == .group || createTicketRequest.oneTicketEqualTo == 0 {
            if let oneTicketEqualTo = createTicketRequest.oneTicketEqualTo {
                let boolValue = Validation.shared.createTicketValidation(text: "\(oneTicketEqualTo)", validationType: .ticketAdmissionPerTicket).0
                let errMsg = Validation.shared.createTicketValidation(text: "\(oneTicketEqualTo)", validationType: .ticketAdmissionPerTicket).1
                return (errMsg, boolValue, .ticketAdmissionPerTicket)
            }
            let boolValue = Validation.shared.createTicketValidation(text: "", validationType: .ticketAdmissionPerTicket).0
            let errMsg = Validation.shared.createTicketValidation(text: "", validationType: .ticketAdmissionPerTicket).1
            return (errMsg, boolValue, .ticketAdmissionPerTicket)
            
        } else if createTicketRequest.donationAmountType?.isEmpty ?? false && self.createTicketType == .donation  {
            
            let boolValue = Validation.shared.createTicketValidation(text: createTicketRequest.donationAmountType ?? "", validationType: .ticketAmountType).0
            let errMsg = Validation.shared.createTicketValidation(text: createTicketRequest.donationAmountType ?? "", validationType: .ticketAmountType).1
            return (errMsg, boolValue, .ticketAmountType)
        }
//        else if createTicketRequest.timeZoneId == nil {
//
//           let boolValue = Validation.shared.createTicketValidation(text: "\(createTicketRequest.timeZoneId ?? 0)", validationType: .ticketTimeZone).0
//           let errMsg = Validation.shared.createTicketValidation(text: "\(createTicketRequest.timeZoneId ?? 0)", validationType: .ticketTimeZone).1
//           return (errMsg, boolValue, .ticketTimeZone)
//       }
        return("", true, .none)
    }
    
    func apiCallCreatePaidTicket(complition:@escaping GetCreateTicketCompletion) {
        APIHandler.shared.executeRequestWith(apiName: .CreatePaidTicket, parameters: self.createTicketRequest, methodType: .POST) { (result: Result<ResponseModal<CreateTicket>, Error>) in
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
