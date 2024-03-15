//
//  AddOrganizerViewModel.swift
//  TicketSpark
//
//  Created by Apple on 26/02/24.
//

import UIKit

typealias AddOrganizationCompletion = (Bool,AddOrganizerModel?,String?)->Void
typealias GetCountryListCompletion = (Bool,[CountryData]?,String?)->Void

class AddOrganizerViewModel {
    // MARK: - VARIABLES
    var countriesModel = [CountryInfo]()
    var countries = [[String: String]]()
    var organizerData:AddOrganizerModel?
    var selectedCountry : CountryInfo?
    
}

// MARK: - FUNCTIONS
extension AddOrganizerViewModel {
    
    public func validate(_ name:String,
                              _ country:String,
                              _ logo:UIImage?) -> (String,Bool) {
            if Validation.shared.textValidation(text: name, validationType: .organizationName).0 {
                let errMsg = Validation.shared.textValidation(text: name, validationType: .organizationName).1
                return (errMsg, false)
            }
            
            if Validation.shared.textValidation(text: country, validationType: .organizationCountry).0 {
                let errMsg = Validation.shared.textValidation(text: country, validationType: .organizationCountry).1
                return (errMsg, false)
            }
        
        if let img = logo, img == UIImage.init(systemName: "plus") {
            return (ValidationConstantStrings.organizationImage, false)
        }
             
       // guard let logo = logo else { return (ValidationConstantStrings.organizationImage, false) }
        
        return ("", true)
    }
    
    
    func createOrganization(name: String, organizationLogo: UIImage, countryId: Int, complition:@escaping AddOrganizationCompletion) {
        guard let imageData = organizationLogo.jpegData(compressionQuality: 0.8) else {
            print("Error converting image to data")
            return
        }
        var body = Data()
        let name = name
        let countryId = countryId
        let organizationLogo = imageData 
        
        // Name Data
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"name\"\r\n\r\n")
        body.append(name.data(using: .utf8)!)
        body.append("\r\n")
        
        // Country ID
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"country_id\"\r\n\r\n")
        body.append(String(countryId).data(using: .utf8)!)
        body.append("\r\n")
        
        // Organization Logo Data
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"organization_logo\"; filename=\"organization_logo.png\"\r\n")
        body.append("Content-Type: organization_logo/png\r\n\r\n")
        body.append(organizationLogo)
        body.append("\r\n")
        body.append("--\(boundary)--\r\n")
        
        
        let param = AddOrganizerRequest(name: name, organizationLogo: imageData, countryId: countryId)
        
        APIHandler.shared.executeRequestWithMultipartData(apiName: .CreateOrganization, parameters: param, methodType: .POST, body: body) { (result: Result<ResponseModal<AddOrganizerModel>, Error>) in
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
    
    func updateOrganizationInfo(organizationId: Int, websiteURL: String, facebookURL: String, twitterURL: String, instagramUrl: String, complition:@escaping AddOrganizationCompletion) {
        let param = UpdateOrganizerRequest(organizationId: organizationId, websiteUrl: websiteURL, facebookUrl: facebookURL, twitterUrl: twitterURL, instagramUrl: instagramUrl)
        
        APIHandler.shared.executeRequestWith(apiName: .UpdateOrganization, parameters: param, methodType: .POST) { (result: Result<ResponseModal<AddOrganizerModel>, Error>) in
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
    
    func getCountryList(complition:@escaping GetCountryListCompletion) {
        APIHandler.shared.executeRequestWith(apiName: .GetAllCountry, parameters: EmptyModel?.none, methodType: .GET) { (result: Result<ResponseModal<[CountryData]>, Error>) in
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
