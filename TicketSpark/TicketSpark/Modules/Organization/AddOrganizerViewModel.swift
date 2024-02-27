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
    
}

// MARK: - FUNCTIONS
extension AddOrganizerViewModel {
    
    public func validate(_ name:String,
                              _ country:String,
                              _ logo:Data?) -> (String,Bool) {
            if Validation.shared.textValidation(text: name, validationType: .organizationName).0 {
                let errMsg = Validation.shared.textValidation(text: name, validationType: .organizationName).1
                return (errMsg, false)
            }
            
            if Validation.shared.textValidation(text: country, validationType: .organizationCountry).0 {
                let errMsg = Validation.shared.textValidation(text: country, validationType: .organizationCountry).1
                return (errMsg, false)
            }
             
        guard let logo = logo else { return (ValidationConstantStrings.organizationImage, false) }
        
        return ("", true)
    }
    
    
    func createOrganization(name: String, organizationLogo: UIImage, countryId: Int, complition:@escaping AddOrganizationCompletion) {
        guard let imageData = organizationLogo.jpegData(compressionQuality: 0.8) else {
            print("Error converting image to data")
            return
        }
        let param = AddOrganizerRequest(name: name, organizationLogo: imageData, countryId: countryId)
        
        APIHandler.shared.executeRequestWithMultipartData(apiName: .CreateOrganization, parameters: param, methodType: .POST) { (result: Result<ResponseModal<AddOrganizerModel>, Error>) in
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
    
    func updateOrganizationInfo(organizationId: Int, websiteURL: String, facebookURL: String, twitterURL: String, linkedinURL: String, complition:@escaping AddOrganizationCompletion) {
        let param = UpdateOrganizerRequest(organizationId: organizationId, websiteUrl: websiteURL, facebookUrl: facebookURL, twitterUrl: twitterURL, linkedinUrl: linkedinURL)
        
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
