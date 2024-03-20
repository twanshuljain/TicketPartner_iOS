//
//  CreateEventModel.swift
//  TicketSpark
//
//  Created by Apple on 01/03/24.
//

import UIKit
import CoreLocation

enum CreateEventType {
    case venue
    case virtual
    case toBeAnnounced
}

enum ScrollTo {
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

struct CreateEventBasicRequest : Encodable {
    var name: String?
    var eventDescription: String?
    var eventStartDate: String?
    var eventEndDate: String?
    var doorCloseDate: String?
    var doorStartDate: String?
    var eventStartTime: String?
    var eventEndTime: String?
    var doorOpenTime: String?
    var doorCloseTime: String?
    var doorCloseTimeRepresents: String?
    var doorOpenTimeRepresents: String?
    var eventEndTimeRepresents: String?
    var eventStartTimeRepresents: String?
    var timeZoneId: Int?
    var eventTypeId: Int?
    var eventCoverImage: Data?
    var eventAdditionalCoverImagesList: [Data?]?
    var mediaFromPastEventImages: [Data?]?
    var isEndTimeShow: Bool?
    //VENUE
    var isVenue: Bool? = true
    var locationName: String? = ""
    var city: String? = ""
    var state: String? = ""
    var country: String? = ""
    var eventAddress: String? = ""
    var venueLat:CLLocationDegrees? = 0.0
    var venueLon:CLLocationDegrees? = 0.0
    //Virtual
    var isVirtual: Bool? = false
    var virtualEventLink: String? = ""
    //ToBeAnnounced
    var isToBeAnnounced: Bool? = false
    var announceEventAddress: String? = ""
    var announceCity: String? = ""
    var announceState: String? = ""
    var announceCountry: String? = ""
    var isEmail: Bool? = false
    var announceLat:CLLocationDegrees? = 0.0
    var announceLon:CLLocationDegrees? = 0.0

    
    enum CodingKeys: String, CodingKey {
        case name
        case eventDescription = "event_description"
        case eventStartDate = "event_start_date"
        case eventEndDate  = "event_end_date"
        case doorCloseDate  = "door_close_date"
        case doorStartDate  = "door_start_date"
        case eventStartTime = "event_start_time"
        case eventEndTime = "event_end_time"
        case doorOpenTime  = "door_open_time"
        case doorCloseTime  = "door_close_time"
        case doorCloseTimeRepresents  = "door_close_time_represents"
        case doorOpenTimeRepresents  = "door_open_time_represents"
        case eventEndTimeRepresents = "event_end_time_represents"
        case eventStartTimeRepresents = "event_start_time_represents"
        case timeZoneId = "time_zone_id"
        case eventTypeId  = "event_type_id"
        case eventCoverImage = "event_cover_image"
        case eventAdditionalCoverImagesList = "event_additional_cover_images_list"
        case mediaFromPastEventImages = "media_from_past_event_images"
        case isEndTimeShow = "is_end_time_show"
        //VENUE
        case isVenue  = "is_venue"
        case locationName = "location_name"
        case city
        case state
        case country
        case eventAddress = "event_address"
        //Virtual
        case isVirtual  = "is_virtual"
        case virtualEventLink  = "virtual_event_link"
        //ToBeAnnounced
        case isToBeAnnounced  = "is_to_be_announced"
        case announceEventAddress = "announce_event_address"
        case announceCity = "announce_city"
        case announceState = "announce_state"
        case announceCountry = "announce_country"
        case isEmail = "is_email"
    }
}

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

// MARK: - StateData
struct StatesData: Codable {
    var id: Int?
    var stateName, stateCode, countryName: String?
    var isActive: Bool?
    var abbreviation: String?
    var countryID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case stateName = "state_name"
        case stateCode = "state_code"
        case countryName = "country_name"
        case isActive = "is_active"
        case abbreviation
        case countryID = "country_id"
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

/*
 name:Canada carnival32
 event_description:string
 event_start_date:2024-11-09
 event_end_date:2024-11-23
 door_close_date:2024-11-09
 door_start_date:2024-11-09
       event_start_time: 11:30
       event_end_time: 11:30
 door_open_time:11:30
 door_close_time:12:00
 door_close_time_represents:am
 door_open_time_represents:pm
       event_end_time_represents: am
       event_start_time_represents:pm
 time_zone_id:1
 event_type_id: 1

 //VENUE
 is_venue:false
 location_name:test
 city:inore
 state:indore
 country:india
 event_address:indore

 //Virtual
 is_virtual:false
 virtual_event_link:https://www.youtube.com/

 //ToBeAnnounced
 is_to_be_announced:true
 announce_event_address:Indore
 announce_city:indore
 announce_state:indore
 announce_country:India
 is_email:True


 organization_id:5
*/

