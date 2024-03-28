//
//  TicketCreatViewModel.swift
//  TicketSpark
//
//  Created by Apple on 22/02/24.
//

import Foundation

enum CreateTicketScroll {
    case eventName
    case eventType
    case eventCover
    case timeZone
    case eventStartDate
    case eventEndDate
    case eventStartTime
    case eventEndTime
    case eventDoorOpenDate
    case eventDoorCloseDate
    case eventDoorOpenTime
    case eventDoorCloseTime
    case eventCountryVenue
    case eventStateVenue
    case eventCityVenue
    case eventLinkVirtual
    case eventCountryToBeAnnounced
    case eventStateToBeAnnounced
    case eventCityToBeAnnounced
    case eventLocationToBeAnnounced
    case none
}

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
