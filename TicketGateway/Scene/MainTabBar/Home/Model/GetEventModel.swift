//
//  GetEventModel.swift
//  TicketGateway
//
//  Created by Apple  on 06/06/23.
//

import UIKit



    // MARK: - Datum
struct GetEventModel: Codable {
    let event: Event?
    let coverImage: CoverImage?
    let location: Location?
    let date: DateClass?

    enum CodingKeys: String, CodingKey {
        case event
        case coverImage
        case location, date
    }
}

// MARK: - CoverImage
struct CoverImage: Codable {
    let eventAdditionalCoverImages: [String]?
    let eventID, id: Int?
    let eventCoverImage: String?

    enum CodingKeys: String, CodingKey {
        case eventAdditionalCoverImages
        case eventID
        case id
        case eventCoverImage
    }
}

// MARK: - DateClass
struct DateClass: Codable {
    let isRecurring: Bool?
    let weeklyOccurs: [String]?
    let dateOccurrence: DateOccurrence?
    let displayStartTime: Bool?
    let eventID: Int?
    let eventEndDate: Date?
    let eventEndTime: String?
    let eventLanguageID, id: Int?
    //
    let eventEndCount, monthRepeatDateOrDay: String?
    let displayEndTime: Bool?
    let eventStartDate: Date?
    let eventStartTime: String?
    let eventTimeZoneID: Int?

    enum CodingKeys: String, CodingKey {
        case isRecurring
        case weeklyOccurs
        case dateOccurrence
        case displayStartTime
        case eventID
        case eventEndDate
        case eventEndTime
        case eventLanguageID
        case id
        case eventEndCount
        case monthRepeatDateOrDay
        case displayEndTime
        case eventStartDate
        case eventStartTime
        case eventTimeZoneID
    }
}

enum DateOccurrence: String, Codable {
    case once = "Once"
}

// MARK: - Event
struct Event: Codable {
    let title: String?
    let customizeWebLink: String?
    let eventPublishType: EventPublishType?
    let ticketID, visitorCount: Int?
    //string
    let eventDescription: String?
    let isPublishNow: Bool?
    //
    let eventAdditionalImageID: String?
    let createdAt: String?
    let formSteps: Int?
    let scheduleEventDate: String?
    let eventOrganizerID: Int?
    let updatedAt: String?
    let isVirtual: Bool?
    //
    let scheduleEventTime: String?
    let eventTypeID: Int?
    let createdBy: String?
    //
    let eventLinks: String?
    let isEmailInvitation: Bool?
    let eventCategoryID, userID: Int?
    //
    let documentLinks: String?
    let isPasswordProtected: Bool?
    let eventSubCategoryID: Int?
    //
    let updatedBy: String?
    let isPublic, isShowOrganizerProfile: Bool?
    let refundPolicyID: Int?
    let isActive: Bool?
    let id: Int?
    let isShowRemainingTickets, isFacilityFee: Bool?

    enum CodingKeys: String, CodingKey {
        case title
        case customizeWebLink
        case eventPublishType
        case ticketID
        case visitorCount
        case eventDescription
        case isPublishNow
        case eventAdditionalImageID
        case createdAt
        case formSteps
        case scheduleEventDate
        case eventOrganizerID
        case updatedAt
        case isVirtual
        case scheduleEventTime
        case eventTypeID
        case createdBy
        case eventLinks
        case isEmailInvitation
        case eventCategoryID
        case userID
        case documentLinks
        case isPasswordProtected
        case eventSubCategoryID
        case updatedBy
        case isPublic
        case isShowOrganizerProfile
        case refundPolicyID
        case isActive
        case id
        case isShowRemainingTickets
        case isFacilityFee
    }
}

enum EventPublishType: String, Codable {
    case live = "LIVE"
}

// MARK: - Location
struct Location: Codable {
    let isVirtual: Bool?
    let virtualTitleImage: String?
    let virtualExternalDocument: String?
    let eventID: Int?
    let isAdditionalSettings: Bool?
    //
    let virtualTitleVideo, addDetailsDescription, eventAddress, virtualImages: String?
    let isToBeAnnounced: Bool?
    //
    let latitude: String?
    let virtualEventHostLink: String?
    let eventCountry: String?
    //
    let longitude, virtualVideoLinks: String?
    let eventState: String?
    let id: Int?
    let virtualLiveVideoURL: String?
    let virtualVideoUrls: VirtualVideoUrls?
    let eventCity: String?
    let virtualEventTitle, locationDescription: String?
    let virtualLinkTitle: String?
    let isAddressField: Bool?
    //
    let additionalCoverImage: String?
    let toBeAnnouncedAddress: String?

    enum CodingKeys: String, CodingKey {
        case isVirtual
        case virtualTitleImage
        case virtualExternalDocument
        case eventID
        case isAdditionalSettings
        case virtualTitleVideo
        case addDetailsDescription
        case eventAddress
        case virtualImages
        case isToBeAnnounced
        case latitude
        case virtualEventHostLink
        case eventCountry
        case longitude
        case virtualVideoLinks
        case eventState
        case id
        case virtualLiveVideoURL
        case virtualVideoUrls
        case eventCity
        case virtualEventTitle
        case locationDescription
        case virtualLinkTitle
        case isAddressField
        case additionalCoverImage
        case toBeAnnouncedAddress
    }
}

enum VirtualVideoUrls: String, Codable {
    case empty = "['']"
}
