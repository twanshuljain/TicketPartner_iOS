//
//  CreatEventViewModel.swift
//  TicketSpark
//
//  Created by Apple on 29/02/24.
//

import Foundation
import UIKit
import CoreLocation
import GooglePlaces

typealias CreateEventCompletion = (Bool,CreateEvent?,String?)->Void
typealias GetTimeZoneCompletion = (Bool,[TimeZone]?,String?)->Void
typealias GetCountryDataCompletion = (Bool,[CountrySpecificData]?,String?)->Void
typealias GetEventTypeDataCompletion = (Bool,[EventType]?,String?)->Void
typealias GetStateDataCompletion = (Bool,[StatesData]?,String?)->Void

class CreatEventViewModel {
    //MARK: - Variables
    var createEventType: CreateEventType = .venue
    var createEvent = CreateEvent(eventData: EventData(), eventDateTimeData: EventDateTimeData(), eventLocationData: EventLocationData())
    var timeZoneData = [TimeZone]()
    var countryData = [CountrySpecificData]()
    var dispatchGroup = DispatchGroup()
    var dispatchGroup1 = DispatchGroup()
    var createEventReq = CreateEventBasicRequest()
    var eventTypeData = [EventType]()
    var locationManager = CLLocationManager()
    var placesClient: GMSPlacesClient!
    var selectedLatLon: CLLocationCoordinate2D?
    var latValue = CLLocationDegrees()
    var longValue = CLLocationDegrees()
    var venueLocationSelected = true
    
}
//MARK: - Functions
extension CreatEventViewModel {
    func validateFields (_ createEventBasicRequest: CreateEventBasicRequest) -> (String,Bool,ScrollTo) {
        if Validation.shared.createEventBasicValidation(text: createEventBasicRequest.name ?? "", validationType: .eventName).0 {
            let errMsg = Validation.shared.createEventBasicValidation(text: createEventBasicRequest.name ?? "", validationType: .eventName).1
            return (errMsg, false, .eventName)
        } else if createEventBasicRequest.eventTypeId == nil {
            let errMsg = ValidationConstantStrings.selectEventType
            return (errMsg, false, .eventType)
        } else if createEventBasicRequest.eventCoverImage == nil {
            let errMsg = ValidationConstantStrings.emptyCoverImage
            return (errMsg, false, .eventCover)
        } else if createEventBasicRequest.timeZoneId == nil {
            let errMsg = ValidationConstantStrings.emptyTimezone
            return (errMsg, false, .timeZone)
        } else if Validation.shared.createEventBasicValidation(text: createEventBasicRequest.eventStartDate ?? "", validationType: .startDate).0 {
            let errMsg = Validation.shared.createEventBasicValidation(text: createEventBasicRequest.eventStartDate ?? "", validationType: .startDate).1
            return (errMsg, false, .eventStartDate)
        } else if Validation.shared.createEventBasicValidation(text: createEventBasicRequest.eventEndDate ?? "", validationType: .endDate).0 {
            let errMsg = Validation.shared.createEventBasicValidation(text: createEventBasicRequest.eventEndDate ?? "", validationType: .endDate).1
            return (errMsg, false, .eventEndDate)
        } else if Validation.shared.createEventBasicValidation(text: createEventBasicRequest.eventStartTime ?? "", validationType: .startTime).0 {
            let errMsg = Validation.shared.createEventBasicValidation(text: createEventBasicRequest.eventStartTime ?? "", validationType: .startTime).1
            return (errMsg, false, .eventStartTime)
        } else if Validation.shared.createEventBasicValidation(text: createEventBasicRequest.eventEndTime ?? "", validationType: .endTime).0 {
            let errMsg = Validation.shared.createEventBasicValidation(text: createEventBasicRequest.eventEndTime ?? "", validationType: .endTime).1
            return (errMsg, false, .eventEndTime)
        }
        else if Validation.shared.createEventBasicValidation(text: createEventBasicRequest.doorStartDate ?? "", validationType: .doorOpenDate).0 {
            let errMsg = Validation.shared.createEventBasicValidation(text: createEventBasicRequest.doorStartDate ?? "", validationType: .doorOpenDate).1
            return (errMsg, false, .eventDoorOpenDate)
        } else if Validation.shared.createEventBasicValidation(text: createEventBasicRequest.doorCloseDate ?? "", validationType: .doorCloseDate).0 {
            let errMsg = Validation.shared.createEventBasicValidation(text: createEventBasicRequest.doorCloseDate ?? "", validationType: .doorCloseDate).1
            return (errMsg, false, .eventDoorCloseDate)
        } else if Validation.shared.createEventBasicValidation(text: createEventBasicRequest.doorOpenTime ?? "", validationType: .doorOpenTime).0 {
            let errMsg = Validation.shared.createEventBasicValidation(text: createEventBasicRequest.doorOpenTime ?? "", validationType: .doorOpenTime).1
            return (errMsg, false,  .eventDoorOpenTime)
        } else if Validation.shared.createEventBasicValidation(text: createEventBasicRequest.doorCloseTime ?? "", validationType: .doorCloseTime).0 {
            let errMsg = Validation.shared.createEventBasicValidation(text: createEventBasicRequest.doorCloseTime ?? "", validationType: .doorCloseTime).1
            return (errMsg, false, .eventDoorCloseTime)
        }
        //Venue
        if self.createEventType == .venue {
            if Validation.shared.createEventBasicValidation(text: createEventBasicRequest.country ?? "", validationType: .country).0 {
                let errMsg = Validation.shared.createEventBasicValidation(text: createEventBasicRequest.country ?? "", validationType: .country).1
                return (errMsg, false, .eventCountryVenue)
            } else if Validation.shared.createEventBasicValidation(text: createEventBasicRequest.state ?? "", validationType: .state).0 {
                let errMsg = Validation.shared.createEventBasicValidation(text: createEventBasicRequest.state ?? "", validationType: .state).1
                return (errMsg, false, .eventStateVenue)
            } else if Validation.shared.createEventBasicValidation(text: createEventBasicRequest.city ?? "", validationType: .city).0 {
                let errMsg = Validation.shared.createEventBasicValidation(text: createEventBasicRequest.city ?? "", validationType: .city).1
                return (errMsg, false, .eventCityVenue)
            }
        } else if self.createEventType == .virtual {
            //Virtual
            if Validation.shared.createEventBasicValidation(text: createEventBasicRequest.virtualEventLink ?? "", validationType: .eventLink).0 {
                let errMsg = Validation.shared.createEventBasicValidation(text: createEventBasicRequest.virtualEventLink ?? "", validationType: .eventLink).1
                return (errMsg, false, .eventLinkVirtual)
            }
        } else {
            //Virtual
            if Validation.shared.createEventBasicValidation(text: createEventBasicRequest.announceCountry ?? "", validationType: .country).0 {
                let errMsg = Validation.shared.createEventBasicValidation(text: createEventBasicRequest.announceCountry ?? "", validationType: .country).1
                return (errMsg, false, .eventCountryToBeAnnounced)
            } else if Validation.shared.createEventBasicValidation(text: createEventBasicRequest.announceState ?? "", validationType: .state).0 {
                let errMsg = Validation.shared.createEventBasicValidation(text: createEventBasicRequest.announceState ?? "", validationType: .state).1
                return (errMsg, false, .eventStateToBeAnnounced)
            } else if Validation.shared.createEventBasicValidation(text: createEventBasicRequest.announceCity ?? "", validationType: .city).0 {
                let errMsg = Validation.shared.createEventBasicValidation(text: createEventBasicRequest.announceCity ?? "", validationType: .city).1
                return (errMsg, false, .eventCityToBeAnnounced)
            }
            if createEventBasicRequest.isEmail ?? false {
                if Validation.shared.createEventBasicValidation(text: createEventBasicRequest.announceEventAddress ?? "", validationType: .locationName).0 {
                    let errMsg = Validation.shared.createEventBasicValidation(text: createEventBasicRequest.announceEventAddress ?? "", validationType: .locationName).1
                    return (errMsg, false, .eventLocationToBeAnnounced)
                }
            }
        }
        return("", true, .none)
    }
    
    // Function to scroll the UIScrollView to the position of the UITextField
    func scrollToTextField(_ textField: UIView, scrollView: UIScrollView) {
        let rect = textField.convert(textField.bounds, to: scrollView)
        scrollView.scrollRectToVisible(rect, animated: true)
    }
    
    func createEventBasics(createEventBasicRequest: CreateEventBasicRequest, complition: @escaping CreateEventCompletion) {
        var body = Data()
        do {
            let arr = try createEventReq.asArrayDictionary()
            // Iterating over each dictionary in the array
            for dictionary in arr {
                // Iterating over key-value pairs in each dictionary
                for (key, value) in dictionary {
                    if key != "event_cover_image" && key != "media_from_past_event_images" && key != "event_additional_cover_images_list" {
                        body.append("--\(boundary)\r\n")
                        body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                        body.append(String(describing: value).data(using: .utf8)!)
                        body.append("\r\n")
                    }
                }
            }
            
            // eventCoverImage
            if let eventCoverImage = createEventBasicRequest.eventCoverImage {
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"event_cover_image\"; filename=\"event_cover_image.png\"\r\n")
                body.append("Content-Type: event_cover_image/png\r\n\r\n")
                body.append(eventCoverImage)
                body.append("\r\n")
            }
            
//            body.append("--\(boundary)\r\n")
//            body.append("Content-Disposition: form-data; name=\"event_additional_cover_images_list\"; filename=\"event_additional_cover_images_list.png\"\r\n")
//            body.append("Content-Type: event_additional_cover_images_list/png\r\n\r\n")
//            body.append((createEventBasicRequest.eventAdditionalCoverImagesList?.first!)!)
//            body.append("\r\n")
//
//            body.append("--\(boundary)\r\n")
//            body.append("Content-Disposition: form-data; name=\"media_from_past_event_images\"; filename=\"media_from_past_event_images.png\"\r\n")
//            body.append("Content-Type: media_from_past_event_images/png\r\n\r\n")
//            body.append((createEventBasicRequest.mediaFromPastEventImages?.first!)!)
//            body.append("\r\n")
            
           //  mediaFromPastEventImages
            if let mediaFromPastEventImages = createEventBasicRequest.mediaFromPastEventImages {
                // Append each image to the body
                for (index, image) in mediaFromPastEventImages.enumerated() {
                    // Add boundary for each image
                    body.append("--\(boundary)\r\n")
                    
                    // Add content disposition header
                    body.append("Content-Disposition: form-data; name=\"image[\(index)]\"; filename=\"image\(index).png\"\r\n")
                    
                    // Add content type header
                    body.append("Content-Type: image/png\r\n\r\n")
                    
                    // Convert image to data and append to body
                    // if let imageData = image.pngData() {
                    body.append(image!)
                    //}
                    
                    // Add newline after each image
                    body.append("\r\n")
                }
            }
            
                    // eventAdditionalCoverImagesList
            if let eventAdditionalCoverImagesList = createEventBasicRequest.eventAdditionalCoverImagesList {
                for (index, image) in eventAdditionalCoverImagesList.enumerated() {
                    body.append("--\(boundary)\r\n")
                    body.append("Content-Disposition: form-data; name=\"image[\(index)]\"; filename=\"image\(index).png\"\r\n")
                    body.append("Content-Type: image/png\r\n\r\n")
                    body.append(image!)
                    body.append("\r\n")
                }
            }
            
            // Add final boundary to indicate the end of the request
            body.append("--\(boundary)--\r\n")
            
            APIHandler.shared.executeRequestWithMultipartData1(apiName: .CreateEvent, methodType: .POST, body: body) { (result: Result<ResponseModal<CreateEvent>, Error>) in
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
        } catch {
            
        }
    }
        
        func getTimeZoneList(complition:@escaping GetTimeZoneCompletion) {
            APIHandler.shared.executeRequestWith(apiName: .GetTimeZone, parameters: EmptyModel?.none, methodType: .GET) { (result: Result<ResponseModal<[TimeZone]>, Error>) in
                switch result {
                case .success(let response):
                    defer { self.dispatchGroup.leave() }
                    if response.status_code == 200 {
                        complition(true, response.data , response.message)
                    } else {
                        complition(false,response.data, response.message ?? "error message")
                    }
                case .failure(let error):
                    defer { self.dispatchGroup.leave() }
                    complition(false, nil, "\(error)")
                }
            }
        }
    
    func getCountryList(complition:@escaping GetCountryDataCompletion) {
        APIHandler.shared.executeRequestWith(apiName: .SpecificCountry, parameters: EmptyModel?.none, methodType: .GET) { (result: Result<ResponseModal<[CountrySpecificData]>, Error>) in
            switch result {
            case .success(let response):
                defer { self.dispatchGroup1.leave() }
                if response.status_code == 200 {
                    complition(true, response.data , response.message)
                } else {
                    complition(false,response.data, response.message ?? "error message")
                }
            case .failure(let error):
                defer { self.dispatchGroup1.leave() }
                complition(false, nil, "\(error)")
            }
        }
    }
    
    func getStates(complition:@escaping GetStateDataCompletion) {
        APIHandler.shared.executeRequestWith(apiName: .GetStates, parameters: EmptyModel?.none, methodType: .GET) { (result: Result<ResponseModal<[StatesData]>, Error>) in
            switch result {
            case .success(let response):
                defer { self.dispatchGroup1.leave() }
                if response.status_code == 200 {
                    complition(true, response.data , response.message)
                } else {
                    complition(false,response.data, response.message ?? "error message")
                }
            case .failure(let error):
                defer { self.dispatchGroup1.leave() }
                complition(false, nil, "\(error)")
            }
        }
    }
    
    func getEventType(complition:@escaping GetEventTypeDataCompletion) {
        APIHandler.shared.executeRequestWith(apiName: .GetEventList, parameters: EmptyModel?.none, methodType: .GET) { (result: Result<ResponseModal<[EventType]>, Error>) in
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
