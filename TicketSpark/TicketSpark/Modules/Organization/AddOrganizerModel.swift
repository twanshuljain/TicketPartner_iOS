//
//  AddOrganizerModel.swift
//  TicketSpark
//
//  Created by Apple on 26/02/24.
//

import UIKit

struct AddOrganizerRequest: Codable {
    let name:String!
    var organizationLogo: Data!
    let countryId: Int!
    
    enum CodingKeys: String, CodingKey {
        case name
        case organizationLogo = "organization_logo"
        case countryId = "country_id"
    }
    
}

struct UpdateOrganizerRequest: Codable {
    var organizationId: Int?
    var websiteUrl: String?
    var facebookUrl: String?
    var twitterUrl: String?
    var linkedinUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case organizationId = "organization_id"
        case websiteUrl = "website_url"
        case facebookUrl = "facebook_url"
        case twitterUrl = "twitter_url"
        case linkedinUrl = "linkedin_url"
    }
    
}

// MARK: - DataClass
struct AddOrganizerModel: Codable {
    var isActive: Bool?
    var name: String?
    var description, facebookURL, linkedinURL: String?
    var countryID: Int?
    var updatedAt: String?
    var id, userID: Int?
    var updatedBy : String?
    var organizationLogo: String
    var websiteURL, twitterURL: String?

    enum CodingKeys: String, CodingKey {
        case isActive = "is_active"
        case name, description
        case facebookURL = "facebook_url"
        case linkedinURL = "linkedin_url"
        case countryID = "country_id"
        case updatedAt = "updated_at"
        case id
        case updatedBy = "updated_by"
        case userID = "user_id"
        case organizationLogo = "organization_logo"
        case websiteURL = "website_url"
        case twitterURL = "twitter_url"
    }
}

// MARK: - Datum
struct CountryData: Codable {
    var countryName: String?
    var isCaribbean: String?
    var id: Int?
    var isActive: Bool?
    var sort, countryCode: String?

    enum CodingKeys: String, CodingKey {
        case countryName = "country_name"
        case isCaribbean = "is_caribbean"
        case id
        case isActive = "is_active"
        case sort
        case countryCode = "country_code"
    }
}
