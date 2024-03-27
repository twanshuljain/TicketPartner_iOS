//
//  CreateTicketModel.swift
//  TicketSpark
//
//  Created by Apple on 26/03/24.
//

import Foundation

// MARK: - CreateTicketRequest
struct CreateTicketRequest: Encodable {
    var ticketName, ticketQuantity, ticketPrice, ticketDescription: String?
    var ticketPerOrderMinimumQuantity, ticketPerOrderMaximumQuantity: Int?
    var ticketVisibility: String?
    var ticketPerUserQuantity: Int?
    var ticketSaleStartDate, ticketSaleEndDate, ticketSaleStartTime, ticketSaleEndTime: String?
    var advanceSetting: Bool?
    var eventID: Int?
    var ticketType: String?
    var ticketPerUser: Bool?
    var isActive, ticketCurrencyType: String?
    
    init() {}
    
    init(ticketName: String, ticketQuantity: String, ticketPrice: String, ticketDescription: String, ticketPerOrderMinimumQuantity: Int, ticketPerOrderMaximumQuantity: Int, ticketVisibility: String, ticketPerUserQuantity: Int, ticketSaleStartDate: String, ticketSaleEndDate: String, ticketSaleStartTime: String, ticketSaleEndTime: String, advanceSetting: Bool? = false, eventID: Int, ticketType: String, ticketPerUser: Bool? = false, isActive: String, ticketCurrencyType: String) {
        self.ticketName = ticketName
        self.ticketQuantity = ticketQuantity
        self.ticketPrice = ticketPrice
        self.ticketDescription = ticketDescription
        self.ticketPerOrderMinimumQuantity = ticketPerOrderMinimumQuantity
        self.ticketPerOrderMaximumQuantity = ticketPerOrderMaximumQuantity
        self.ticketVisibility = ticketVisibility
        self.ticketPerUserQuantity = ticketPerUserQuantity
        self.ticketSaleStartDate = ticketSaleStartDate
        self.ticketSaleEndDate = ticketSaleEndDate
        self.ticketSaleStartTime = ticketSaleStartTime
        self.ticketSaleEndTime = ticketSaleEndTime
        self.advanceSetting = advanceSetting
        self.eventID = eventID
        self.ticketType = ticketType
        self.ticketPerUser = ticketPerUser
        self.isActive = isActive
        self.ticketCurrencyType = ticketCurrencyType
    }

    enum CodingKeys: String, CodingKey {
        case ticketName = "ticket_name"
        case ticketQuantity = "ticket_quantity"
        case ticketPrice = "ticket_price"
        case ticketDescription = "ticket_description"
        case ticketPerOrderMinimumQuantity = "ticket_per_order_minimum_quantity"
        case ticketPerOrderMaximumQuantity = "ticket_per_order_maximum_quantity"
        case ticketVisibility = "ticket_visibility"
        case ticketPerUserQuantity = "ticket_per_user_quantity"
        case ticketSaleStartDate = "ticket_sale_start_date"
        case ticketSaleEndDate = "ticket_sale_end_date"
        case ticketSaleStartTime = "ticket_sale_start_time"
        case ticketSaleEndTime = "ticket_sale_end_time"
        case advanceSetting = "advance_setting"
        case eventID = "event_id"
        case ticketType = "ticket_type"
        case ticketPerUser = "ticket_per_user"
        case isActive = "is_active"
        case ticketCurrencyType = "ticket_currency_type"
    }
}
