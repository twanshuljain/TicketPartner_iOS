//
//  CreateEventModel.swift
//  TicketSpark
//
//  Created by Apple on 01/03/24.
//

import UIKit

enum CreateEventType {
    case venue
    case virtual
    case toBeAnnounced
}

struct CreateEventBasicRequest : Encodable {
    var name: String?
    var timeZone: String?
    var eventDescription: String?
    var eventStartDate: String?
    var eventEndDate: String?
    var doorCloseDate: String?
    var doorStartDate: String?
    var doorOpenTime: String?
    var doorCloseTime: String?
    var doorCloseTimeRepresents: String?
    var doorOpenTimeRepresents: String?
    var eventTypeId: Int?
    var eventCoverImage: Data?
    var eventAdditionalCoverImagesList: [Data?]?
    var mediaFromPastEventImages: [Data?]?
    //Virtual
    var isVirtual: Bool?
    var virtualEventLink: String?
    //VENUE
    var isVenue: Bool?
    var locationName: String?
    var city: String?
    var stateId: String?
    var countryId: String?
    var eventAddress: String?
    //ToBeAnnounced
    var isToBeAnnounced: Bool?
 //   var locationName: String?
 //   var city: String?
    var isEmail: Bool?
    var state: String?
    var country: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case timeZone = "time_zone"
        case eventCoverImage = "event_cover_image"
        case eventAdditionalCoverImagesList = "event_additional_cover_images_list"
        case mediaFromPastEventImages = "media_from_past_event_images"
        case eventDescription = "event_description"
        case eventStartDate = "event_start_date"
        case eventEndDate  = "event_end_date"
        case doorCloseDate  = "door_close_date"
        case doorStartDate  = "door_start_date"
        case doorOpenTime  = "door_open_time"
        case doorCloseTime  = "door_close_time"
        case doorCloseTimeRepresents  = "door_close_time_represents"
        case doorOpenTimeRepresents  = "door_open_time_represents"
        case isVirtual  = "is_virtual"
        case virtualEventLink  = "virtual_event_link"
        case eventTypeId  = "event_type_id"
        case isVenue  = "is_venue"
        case locationName = "location_name"
        case city
        case stateId = "state_id"
        case countryId = "country_id"
        case eventAddress = "event_address"
        case isToBeAnnounced  = "is_to_be_announced"
        case isEmail = "is_email"
        case state
        case country
        
    }
}

//struct CreateEventVenueBasicRequest : Encodable {
//    var name: String?
//    var eventDescription: String?
//    var eventStartDate: String?
//    var eventEndDate: String?
//    var doorCloseDate: String?
//    var doorStartDate: String?
//    var doorOpenTime: String?
//    var doorCloseTime: String?
//    var doorCloseTimeRepresents: String?
//    var doorOpenTimeRepresents: String?
//    var isVenue: Bool?
//    //var virtualEventLink: String?
//    var eventTypeId: Int?
//    var locationName: String?
//    var city: String?
//    var stateId: String?
//    var countryId: String?
//    var eventAddress: String?
//
//    enum CodingKeys: String, CodingKey {
//        case name
//        case eventDescription = "event_description"
//        case eventStartDate = "event_start_date"
//        case eventEndDate  = "event_end_date"
//        case doorCloseDate  = "door_close_date"
//        case doorStartDate  = "door_start_date"
//        case doorOpenTime  = "door_open_time"
//        case doorCloseTime  = "door_close_time"
//        case doorCloseTimeRepresents  = "door_close_time_represents"
//        case doorOpenTimeRepresents  = "door_open_time_represents"
//      //  case virtualEventLink  = "virtual_event_link"
//        case isVenue  = "is_venue"
//        case eventTypeId  = "event_type_id"
//        case locationName = "location_name"
//        case city
//        case stateId = "state_id"
//        case countryId = "country_id"
//        case eventAddress = "event_address"
//    }
//}
//
//struct CreateEventToBeAnnouncedBasicRequest : Encodable {
//    var name: String?
//    var eventDescription: String?
//    var eventStartDate: String?
//    var eventEndDate: String?
//    var doorCloseDate: String?
//    var doorStartDate: String?
//    var doorOpenTime: String?
//    var doorCloseTime: String?
//    var doorCloseTimeRepresents: String?
//    var doorOpenTimeRepresents: String?
//    var isToBeAnnounced: Bool?
//    //var virtualEventLink: String?
//    var eventTypeId: Int?
//    var locationName: String?
//    var city: String?
//    var isEmail: String?
//    var state: String?
//    var country: String?
//
//
//    enum CodingKeys: String, CodingKey {
//        case name
//        case eventDescription = "event_description"
//        case eventStartDate = "event_start_date"
//        case eventEndDate  = "event_end_date"
//        case doorCloseDate  = "door_close_date"
//        case doorStartDate  = "door_start_date"
//        case doorOpenTime  = "door_open_time"
//        case doorCloseTime  = "door_close_time"
//        case doorCloseTimeRepresents  = "door_close_time_represents"
//        case doorOpenTimeRepresents  = "door_open_time_represents"
//        case isToBeAnnounced  = "is_to_be_announced"
//      //  case virtualEventLink  = "virtual_event_link"
//        case eventTypeId  = "event_type_id"
//        case locationName = "location_name"
//        case city
//        case isEmail = "is_email"
//        case state
//        case country
//
//    }
//}

// MARK: - DataClass
struct CreateEvent: Codable {
    var eventData: EventData?
    var eventDateTimeData: EventDateTimeData?
    var eventLocationData: EventLocationData?
    
    init(eventData: EventData, eventDateTimeData: EventDateTimeData, eventLocationData: EventLocationData) {
        self.eventData = eventData
        self.eventDateTimeData = eventDateTimeData
        self.eventLocationData = eventLocationData
    }

    enum CodingKeys: String, CodingKey {
        case eventData = "event_obj"
        case eventDateTimeData = "event_date_time_obj"
        case eventLocationData = "event_location_obj"
    }
}

// MARK: - EventData
struct EventData: Codable {
    var createdAt: String?
    var isActive: Bool?
    var userID: Int?
    var eventDescription: String?
    var pastEventImages: [String]?
    var eventTypeID: Int?
    var updatedAt: String?
    var id: Int?
    var name: String?
    var eventAdditionalCoverImages: [String]?
    var eventCoverImage: String?

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case isActive = "is_active"
        case userID = "user_id"
        case eventDescription = "event_description"
        case pastEventImages = "past_event_images"
        case eventTypeID = "event_type_id"
        case updatedAt = "updated_at"
        case id
        case name
        case eventAdditionalCoverImages = "event_additional_cover_images"
        case eventCoverImage = "event_cover_image"
    }
}

// MARK: - EventDateTimeObj
struct EventDateTimeData: Codable {
    var id: Int?
    var eventEndDate: String?
    var doorOpenTime, createdAt: String?
    var eventStartTime: String?
    var doorCloseTime, updatedAt: String?
    var eventEndTime: String?
    var doorCloseTimeRepresents: String?
    var eventStartTimeRepresents: String?
    var doorOpenTimeRepresents: String?
    var eventEndTimeRepresents, timeZoneID: String?
    var isActive: Bool?
    var doorOpenDate: String?
    var eventID: Int?
    var doorCloseDate, eventStartDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case eventEndDate = "event_end_date"
        case doorOpenTime = "door_open_time"
        case createdAt = "created_at"
        case eventStartTime = "event_start_time"
        case doorCloseTime = "door_close_time"
        case updatedAt = "updated_at"
        case eventEndTime = "event_end_time"
        case doorCloseTimeRepresents = "door_close_time_represents"
        case eventStartTimeRepresents = "event_start_time_represents"
        case doorOpenTimeRepresents = "door_open_time_represents"
        case eventEndTimeRepresents = "event_end_time_represents"
        case timeZoneID = "time_zone_id"
        case isActive = "is_active"
        case doorOpenDate = "door_open_date"
        case eventID = "event_id"
        case doorCloseDate = "door_close_date"
        case eventStartDate = "event_start_date"
    }
}

// MARK: - EventLocationObj
struct EventLocationData: Codable {
    var createdAt: String?
    var isActive, isToBeAnnounced: Bool?
    var locationName, eventAddress, state: String?
    var virtualEventLink: String?
    var eventID, id: Int?
    var updatedAt: String?
    var isVirtual, isVenue: Bool?
    var city, country: String?
    var isEmail: Bool?

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case isActive = "is_active"
        case isToBeAnnounced = "is_to_be_announced"
        case locationName = "location_name"
        case eventAddress = "event_address"
        case state
        case virtualEventLink = "virtual_event_link"
        case eventID = "event_id"
        case id
        case updatedAt = "updated_at"
        case isVirtual = "is_virtual"
        case isVenue = "is_venue"
        case city, country
        case isEmail = "is_email"
    }
}


// MARK: - Time Zone
struct TimeZone: Codable {
    var isActive: Bool?
    var timeZoneID: String?
    var id: Int?
    var timeZoneName: String?
    
    enum CodingKeys: String, CodingKey {
        case isActive = "is_active"
        case timeZoneID = "time_zone_id"
        case id
        case timeZoneName = "time_zone_name"
    }
}

// MARK: - CountryData
struct CountrySpecificData: Codable {
    var id: Int?
    var countryName, isCaribbean, image: String?
    var isActive: Bool?
    var sort, countryCode: String?

    enum CodingKeys: String, CodingKey {
        case id
        case countryName = "country_name"
        case isCaribbean = "is_caribbean"
        case image
        case isActive = "is_active"
        case sort
        case countryCode = "country_code"
    }
}

// MARK: - EventType
struct EventType: Codable {
    var id: Int?
    var eventTypeTitle: String?
    var isActive: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case eventTypeTitle = "event_type_title"
        case isActive = "is_active"
    }
}
