//
//  TicketCreatViewModel.swift
//  TicketSpark
//
//  Created by Apple on 22/02/24.
//

import Foundation

struct TicketTypeModel {
    let ticketType: String
    var isSelected: Bool = false
}
class TicketCreateViewModel {
    // MARK: - Variables
    var ticketType: [TicketTypeModel] = []
//    ["Paid Ticket", "Free Ticket", "Group", "Donation"]
    var numberOfRow: Int {
        return ticketType.count
    }
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
}
