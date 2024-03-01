//
//  CreatEventViewModel.swift
//  TicketSpark
//
//  Created by Apple on 29/02/24.
//

import Foundation

typealias CreateEventCompletion = (Bool,CreateEvent?,String?)->Void

class CreatEventViewModel {
    //MARK: - Variables
    var createEventType: CreateEventType = .venue
    
}
//MARK: - Functions
extension CreatEventViewModel {
    
    func createEventBasics(createEventBasicRequest: CreateEventBasicRequest, complition: @escaping CreateEventCompletion) {
        var body = Data()
        var arr = [[String:Any]]()
        arr.append(["name":createEventBasicRequest.name ?? ""])
        arr.append(["event_description":createEventBasicRequest.eventDescription ?? ""])
        arr.append(["event_start_date":createEventBasicRequest.eventStartDate ?? ""])
        arr.append(["event_end_date":createEventBasicRequest.eventEndDate ?? ""])
        arr.append(["event_type_id":createEventBasicRequest.eventTypeId ?? ""])
        arr.append(["door_start_date":createEventBasicRequest.doorStartDate ?? ""])
        arr.append(["door_close_date":createEventBasicRequest.doorCloseDate ?? ""])
        arr.append(["door_open_time":createEventBasicRequest.doorOpenTime ?? ""])
        arr.append(["door_close_time":createEventBasicRequest.doorCloseTime ?? ""])
        arr.append(["door_open_time_represents":createEventBasicRequest.doorOpenTimeRepresents ?? ""])
        arr.append(["door_close_time_represents":createEventBasicRequest.doorCloseTimeRepresents ?? ""])
        arr.append(["is_virtual":createEventBasicRequest.isVirtual ?? ""])
        arr.append(["virtual_event_link":createEventBasicRequest.virtualEventLink ?? ""])
        arr.append(["is_venue":createEventBasicRequest.isVenue ?? ""])
        arr.append(["location_name":createEventBasicRequest.locationName ?? ""])
        arr.append(["city":createEventBasicRequest.city ?? ""])
        arr.append(["state_id":createEventBasicRequest.stateId ?? ""])
        arr.append(["country_id":createEventBasicRequest.countryId ?? ""])
        arr.append(["event_address":createEventBasicRequest.eventAddress ?? ""])
        arr.append(["is_email":createEventBasicRequest.isEmail ?? ""])
        arr.append(["state":createEventBasicRequest.state ?? ""])
        arr.append(["is_to_be_announced":createEventBasicRequest.isToBeAnnounced ?? ""])
        arr.append(["country":createEventBasicRequest.country ?? ""])
        
        // Iterating over each dictionary in the array
        for dictionary in arr {
            // Iterating over key-value pairs in each dictionary
            for (key, value) in dictionary {
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append(String(describing: value).data(using: .utf8)!)
                body.append("\r\n")
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
        
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"event_additional_cover_images_list\"; filename=\"event_additional_cover_images_list.png\"\r\n")
        body.append("Content-Type: event_additional_cover_images_list/png\r\n\r\n")
        body.append((createEventBasicRequest.eventAdditionalCoverImagesList?.first!)!)
        body.append("\r\n")
        
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"media_from_past_event_images\"; filename=\"media_from_past_event_images.png\"\r\n")
        body.append("Content-Type: media_from_past_event_images/png\r\n\r\n")
        body.append((createEventBasicRequest.mediaFromPastEventImages?.first!)!)
        body.append("\r\n")
        
        // mediaFromPastEventImages
//        if let mediaFromPastEventImages = createEventBasicRequest.mediaFromPastEventImages {
//            // Append each image to the body
//            for (index, image) in mediaFromPastEventImages.enumerated() {
//                   // Add boundary for each image
//                   body.append("--\(boundary)\r\n")
//
//                   // Add content disposition header
//                   body.append("Content-Disposition: form-data; name=\"image[\(index)]\"; filename=\"image\(index).png\"\r\n")
//
//                   // Add content type header
//                   body.append("Content-Type: image/png\r\n\r\n")
//
//                   // Convert image to data and append to body
//                  // if let imageData = image.pngData() {
//                       body.append(image!)
//                   //}
//
//                   // Add newline after each image
//                   body.append("\r\n")
//               }
//        }
//
//        // eventAdditionalCoverImagesList
//        if let eventAdditionalCoverImagesList = createEventBasicRequest.eventAdditionalCoverImagesList {
//            for (index, image) in eventAdditionalCoverImagesList.enumerated() {
//                   body.append("--\(boundary)\r\n")
//                   body.append("Content-Disposition: form-data; name=\"image[\(index)]\"; filename=\"image\(index).png\"\r\n")
//                   body.append("Content-Type: image/png\r\n\r\n")
//                   body.append(image!)
//                   body.append("\r\n")
//               }
//        }
        
        // Add final boundary to indicate the end of the request
        body.append("--\(boundary)--\r\n")
        
        APIHandler.shared.executeRequestWithMultipartData1(apiName: .createEvent, methodType: .POST, body: body) { (result: Result<ResponseModal<CreateEvent>, Error>) in
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
