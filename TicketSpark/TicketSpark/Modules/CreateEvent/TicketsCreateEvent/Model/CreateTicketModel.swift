//
//  CreateTicketModel.swift
//  TicketSpark
//
//  Created by Apple on 26/03/24.
//

import Foundation

// MARK: - CreateTicketRequest
struct CreateTicketRequest: Encodable {
    var ticketName, ticketDescription: String?
    var ticketQuantity, ticketPrice, oneTicketEqualTo: Int?
    var ticketPerOrderMinimumQuantity, ticketPerOrderMaximumQuantity: Int?
    var ticketVisibility: String?
    var ticketPerUserQuantity: Int?
    var ticketSaleStartDate, ticketSaleEndDate, ticketSaleStartTime, ticketSaleEndTime: String?
    var advanceSetting: Bool?
    var eventID: Int?
    var ticketType: String?
    var ticketPerUser: Bool?
    var isActive, ticketCurrencyType: String?
    var timeZoneId: Int?
    var donationAmountType: String?
    
    init() {}
    
    init(ticketName: String, ticketQuantity: Int, ticketPrice: Int, ticketDescription: String, ticketPerOrderMinimumQuantity: Int, ticketPerOrderMaximumQuantity: Int, ticketVisibility: String, ticketPerUserQuantity: Int, ticketSaleStartDate: String, ticketSaleEndDate: String, ticketSaleStartTime: String, ticketSaleEndTime: String, advanceSetting: Bool? = false, eventID: Int, ticketType: String, ticketPerUser: Bool? = false, isActive: String, ticketCurrencyType: String, oneTicketEqualTo: Int, timeZoneId: Int, donationAmountType: String) {
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
        self.oneTicketEqualTo = oneTicketEqualTo
        self.timeZoneId = timeZoneId
        self.donationAmountType = donationAmountType
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
        case oneTicketEqualTo = "one_ticket_equal_to"
        case timeZoneId = "time_zone_id"
        case donationAmountType = "donation_amount_type"
    }
}


// MARK: - CreateTicket
struct CreateTicket: Codable {
    var createdAt, ticketType, ticketDescription: String?
    var advanceSetting: Bool?
    var updatedAt, ticketCurrencyType: String?
    var ticketQuantity: Int?
    var orderStatus: String?
    var ticketName: String?
    var ticketPrice: Int?
    var ticketNameWithType: String?
    var ticketSaleStartDate: String?
    var ticketPerOrderMinimumQuantity, ticketPerOrderMaximumQuantity: Int?
    var isActive: Bool?
    var ticketSaleEndDate: String?
    var isAccessCode, isAccessCodeApplied: Bool?
    var eventID: Int?
    var ticketSaleStartTime: String?
    var ticketPerUserQuantity: Int?
    var isSaleEnded: Bool?
    var id: Int?
    var ticketID: Int?
    var ticketSaleEndTime: String?
    var ticketPerUser, isAllowToChangeCurrency: Bool?
    var userID: Int?
    var ticketVisibility: String?

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case ticketType = "ticket_type"
        case ticketDescription = "ticket_description"
        case advanceSetting = "advance_setting"
        case updatedAt = "updated_at"
        case ticketCurrencyType = "ticket_currency_type"
        case ticketQuantity = "ticket_quantity"
        case orderStatus = "order_status"
        case ticketName = "ticket_name"
        case ticketPrice = "ticket_price"
        case ticketNameWithType = "ticket_name_with_type"
        case ticketSaleStartDate = "ticket_sale_start_date"
        case ticketPerOrderMinimumQuantity = "ticket_per_order_minimum_quantity"
        case isAccessCodeApplied = "is_access_code_applied"
        case isActive = "is_active"
        case ticketSaleEndDate = "ticket_sale_end_date"
        case ticketPerOrderMaximumQuantity = "ticket_per_order_maximum_quantity"
        case isAccessCode = "is_access_code"
        case eventID = "event_id"
        case ticketSaleStartTime = "ticket_sale_start_time"
        case ticketPerUserQuantity = "ticket_per_user_quantity"
        case isSaleEnded = "is_sale_ended"
        case id
        case ticketID = "ticket_id"
        case ticketSaleEndTime = "ticket_sale_end_time"
        case ticketPerUser = "ticket_per_user"
        case isAllowToChangeCurrency = "is_allow_to_change_currency"
        case userID = "user_id"
        case ticketVisibility = "ticket_visibility"
    }
}
